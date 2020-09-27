import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;

  Header({ this.text });

  @override
  Widget build(BuildContext context) {
    return  Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 36,
          fontFamily: "Roboto Slab",
          fontWeight: FontWeight.bold,
        )
    );
  }
}