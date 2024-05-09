import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.width,
    required this.left,
    required this.right,
    this.color = const Color(0xFF4D8BAA),
    this.textColor = Colors.white,
    this.borderRadius = 15,
    this.icon, // Changed from Icon to Icon?
  }); // Added super constructor call

  final Function()? onTap;
  final String title;
  final double width;
  final double left;
  final double right;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final Icon? icon; // Changed type to Icon?

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: width,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(left, 5, right, 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add some space between icon and text
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            if (icon != null) // Add a check for null icon
              Icon(
                icon!.icon,
                color: color,
              ), // Add Icon here
          ],
        ),
      ),
    );
  }
}
