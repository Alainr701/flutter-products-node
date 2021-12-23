import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:products_app/providers/product_form_provider.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart'; 
class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductServices>(context);
    return ChangeNotifierProvider(
      create: (context) =>ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
      );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductServices productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
            Stack(
              children: [
                ProductImage(url:productService.selectedProduct.picture),
                Positioned(
                  top: 15,
                  left: 5,
                  child: IconButton(
                  onPressed: ()=>Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back,color: Colors.white, size: 45))),
                Positioned(
                  top: 15,
                  right: 20,
                  child: IconButton(
                  onPressed: ()async{
                    final imagePicker = ImagePicker();
                    final PickedFile? pickedFile = await imagePicker.getImage(
                      source: ImageSource.camera,
                      imageQuality: 100
                      );  
                    if (pickedFile == null) {
                      print('no preciono nada');
                      return;
                    }
                    print('Teenmos img ${pickedFile.path}');
                    productService.updateSelectedProductImage(pickedFile.path);
                  },

                  icon: const Icon(Icons.photo_camera,color: Colors.white, size: 45))),
             
              ],
            ),
             _FormProduct(),
              const SizedBox(height: 100),
          ],
          
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          
          onPressed: 
          productService.isSaving?null
          :()async{
          if (!productForm.isValidForm()) return;
          String? imgUrl = await productService.uploadImage();
          // print('img $imgUrl');
          if (imgUrl != null) productForm.product.picture = imgUrl;
          await productService.saveOrCreateProduct(productForm.product);

        },child:
        productService.isSaving?
        const CircularProgressIndicator()
        :const Icon(Icons.save,color: Colors.white,),),
      ),
    );
  }
}

class _FormProduct extends StatelessWidget {
  const _FormProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Form(
        key: productForm.formKey,
        autovalidateMode:AutovalidateMode.onUserInteraction ,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product.name,
              onChanged: (value) => product.name = value,
              validator: (value) {
                if (value == null || value.length<1 ){
                  return 'El nombre es requerido';
                }
              },
              decoration: InputDecorations.authInputDecoration(hintText: 'Nombre Producto', labelText: 'Nombre')
            ),
            const SizedBox(height: 20),
            TextFormField(
               initialValue: product.price.toString(),
               inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
               ],
              onChanged: (value) {
                 if (double.tryParse(value)==null){
                  product.price = 0;
                }else{
                  product.price = double.parse(value);
                }
              },
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(hintText: '\$150', labelText: 'Precio')
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Disponible'),
              value: product.available, onChanged: productForm.updateAvailable),
            const SizedBox(height: 20),

          ],
        ),
        ),
      

    );
  }
}