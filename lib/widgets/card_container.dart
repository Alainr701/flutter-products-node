import 'package:flutter/material.dart';
class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.6,
      decoration: boxDecoration(),
      padding: const EdgeInsets.all(20),
      child: child,
      
    );
  }

  BoxDecoration boxDecoration() => const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
      ),
  );
}