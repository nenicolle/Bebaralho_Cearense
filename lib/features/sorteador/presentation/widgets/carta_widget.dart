import 'package:flutter/material.dart';

class CartaWidget extends StatelessWidget {
  final String imagePath;

  const CartaWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath, height: 600, fit: BoxFit.contain);
  }
}
