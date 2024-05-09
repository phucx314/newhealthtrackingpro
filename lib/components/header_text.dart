// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../colors/color_set.dart';

class MyHeaderText extends StatelessWidget {
  final String text;

  const MyHeaderText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        color: htaPrimaryColors.shade500,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
