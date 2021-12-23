import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:products_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductServices extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-f649c-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;
  File? newPictureFile;
  
  bool isLoading = true;
  bool isSaving = false;

  ProductServices() {
    loadProducts();
  }

  Future<List<Product>> loadProducts () async {
    isLoading=true;
    notifyListeners();
    final url  = Uri.https(_baseUrl,'products.json');
    
    final response = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(response.body);    
  
    productsMap.forEach((key, value) { 
      final tempProduct = Product.fromMap(value);
       tempProduct.id = key; // agregamos el id
       products.add(tempProduct);// agregamos el producto al listado
    });
    isLoading=false;
    notifyListeners();

    // print(products[0].id);
    return products; //is not necessary
  }
  
  Future saveOrCreateProduct (Product product)async{
      isSaving=true;
      notifyListeners();

      if (product.id == null) {
     await createProduct(product);
      
      }else{
        await updateProduct(product);
      }

      isSaving=false;
      notifyListeners();
  }

  Future<String> updateProduct (Product product)async{
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final response = await http.put(url, body: product.toJson());
   final decodeData = json.decode(response.body);
    print(decodeData );
    //buscar en la lista el id
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct (Product product)async{
    final url = Uri.https(_baseUrl, 'products.json');
    final response = await http.post(url, body: product.toJson());
    final decodeData = json.decode(response.body);
    print(decodeData );
    product.id = decodeData['name'];
    products.add(product);
    return '';
  }

  //img
  void updateSelectedProductImage (String path){
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri.parse(path));
    notifyListeners();
  }

  Future<String?> uploadImage() async{
    if (newPictureFile == null) return null;

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dd99litjv/image/upload?upload_preset=jxaklmtj');
  
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);
    if (response.statusCode != 200 && response.statusCode != 201) {
      print('Algo salio mal');
      print(response.body);
      return null;
    }

    newPictureFile = null;

  final decodeData = json.decode(response.body);
  return decodeData['secure_url'];

  }

}