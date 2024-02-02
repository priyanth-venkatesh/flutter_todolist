import 'package:flutter/material.dart' ;
// Import 'dart:ffi' only for non-web platforms


class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed, 
    });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Color.fromARGB(255, 188, 149, 255),
      child: Text(text),
    );
  }
}