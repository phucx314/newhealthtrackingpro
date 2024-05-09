import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onTap,
    required this.title,
    this.width = 100,
    // required this.left,
    // required this.right,
    this.color = const Color(0xFF4D8BAA),
    this.textColor = Colors.white, // Default value for textColor
    this.borderColor = Colors.transparent,
  });

  final Function()? onTap;
  final String title;
  final double width;
  // final double left;
  // final double right;
  final Color color;
  final Color textColor; // Not nullable anymore
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap, // Đặt onTap ở đây để toàn bộ Container nhận được sự kiện onTap
      child: Container(
        height: 60,
        width: width,
        padding: const EdgeInsets.all(10),
        // margin: EdgeInsets.fromLTRB(left, 0, right, 0),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
