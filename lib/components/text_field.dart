import 'package:flutter/material.dart';
import '../styles/box_shadow.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key, // Fix the super.key to Key? key
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.height = 50.0, // Add this line with a default value
  }); // Fix the super.key placement

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final double height; // Add this line

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, // Use the height property here
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15.0), boxShadow: [
        shadow,
      ]),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black38),
        ),
      ),
    );
  }
}
