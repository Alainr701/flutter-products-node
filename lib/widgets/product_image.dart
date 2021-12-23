
import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 400,
        color: Colors.black,
        child: getImage(url));
  }
  Widget getImage(String? picture ){
    if(picture == null) return const Image(image: AssetImage('assets/no-image.png'),fit: BoxFit.cover);
    if (picture.startsWith('http')){
      return FadeInImage(
          image: NetworkImage(url!),
          placeholder: const AssetImage('assets/jar-loading.gif'),
          fit: BoxFit.cover,
        );
    }
    return Image.file(File(picture),fit: BoxFit.cover,);
  }
}
