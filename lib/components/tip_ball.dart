// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../colors/color_set.dart';
import '../models/tip_ball.dart';

class TipBall extends StatelessWidget {
  final String imageUrl;
  final String emoji;
  final String title;
  final VoidCallback? onTap; // Function to execute when tapped

  const TipBall({
    super.key,
    required this.imageUrl,
    required this.emoji,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Execute onTap function when tapped
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: htaPrimaryColors.shade300,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(imageUrl),
              child: Center(
                child: Text(
                  emoji,
                  style: TextStyle(
                    fontSize: 24,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 30,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
