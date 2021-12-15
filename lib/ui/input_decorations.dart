import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? icon,
  }) {
    return InputDecoration(
        enabledBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: icon != null?Icon(Icons.email):null );
  }
}
