import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';
import 'package:products_app/screens/loading_screen.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productServices = Provider.of<ProductServices>(context);
    if (productServices.isLoading) return const LoadingScreen();
    return   Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: productServices.products.length,
        itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            productServices.selectedProduct = productServices.products[index].copy();
            Navigator.pushNamed(context, 'product');
            },
          child: ProductCard(product:productServices.products[index]));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        productServices.selectedProduct = Product(available: false, name: '', price: 0.0); 
        Navigator.of(context).pushNamed('product');
      },child: const Icon(Icons.add)),
    );
  }
}