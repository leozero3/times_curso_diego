import 'package:flutter/material.dart';
//brasao

class Brasao extends StatelessWidget {
  const Brasao({Key? key, required this.image, required this.width}) : super(key: key);

  final String image;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: image,
        child: Image.network(
          image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
