import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart'; 
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, bottom: 40),
        height: 400,
        decoration: buildBoxDecoration(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children:  [
            _BackgroundImage( product.picture),
            _ProductsDetails(product: product),
            if(product.available)const _NotAvailable()
          ],
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow( 
            blurRadius: 5,
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(0, 5),

          )
        ]

  );

}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 20,
      child: Container(
        width: 40,
        height: 70,
        decoration: _builBoxDercoration(),
        child: const Center(
          child: Icon(
            Icons.check_circle_outline,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  BoxDecoration _builBoxDercoration() => BoxDecoration(
        color:Colors.blue ,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 5),
          )
        ]
  );
}

class _ProductsDetails extends StatelessWidget {
  final Product product;

  const _ProductsDetails({Key? key, required this.product}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(product.name,style: TextStyle(color: Colors.white,fontSize: 20,overflow: TextOverflow.ellipsis)),
            Text('id: ${product.id}',style: TextStyle(color: Colors.white,fontSize: 10,overflow: TextOverflow.ellipsis)),
            Text('Price: \$${product.price}',style: TextStyle(color: Colors.white,fontSize: 15,overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        color: Colors.blue,
        borderRadius:  BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
  );
}

class _BackgroundImage extends StatelessWidget {
  final String? picture;
  const _BackgroundImage(this.picture);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child:  SizedBox(
        width: double.infinity,
        height: 400,
        child: 
          picture==null?
          Image.asset('assets/no-image.png',fit: BoxFit.cover)
          :FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(picture!),
          fit: BoxFit.cover,
         ),
      ),
    );
  }
}