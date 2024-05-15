import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../colors/color_set.dart';
import '../styles/box_shadow.dart';

class Feature extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap; // Callback function for tap event

  const Feature(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Add onTap callback here
      child: Container(
        height: 120, width: 160,
        decoration: BoxDecoration(
          color: htaPrimaryColors.shade50,
          boxShadow: [
            shadow,
          ],
          borderRadius: BorderRadius.circular(15),
        ),

        // icon
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    icon, // Icon text from the model
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    title, // Title text from the model
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
