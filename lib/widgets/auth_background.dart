import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.blue,
      width: double.infinity,
      height: double.infinity,
    
      child: Stack(
        children: [
          const _HeaderBackground(),
          // SafeArea(child: Container(

          //   width: double.infinity,
          //   margin: EdgeInsets.only(top: 30),
          //   child: Icon(Icons.person_pin,color: Colors.white,size: 100,)))
          child,
        ],
      ),
    );
  }
}

class _HeaderBackground extends StatelessWidget {
  const _HeaderBackground({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo.png'),
          fit: BoxFit.cover,
        ),
        color: Colors.blue,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
      ),
    );
  }
}
