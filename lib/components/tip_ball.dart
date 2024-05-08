// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../colors/color_set.dart';
import '../models/tip_ball.dart';

class TipBall extends StatelessWidget {
  final Tip tip;

  const TipBall({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ảnh nền
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: htaPrimaryColors.shade300, width: 3.0), // Đặt viền
            borderRadius: BorderRadius.circular(30), // Đặt bo tròn cho viền
          ),
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(tip.imageUrl),
            child: Center(
              child: Text(
                tip.emoji,
                style: TextStyle(fontSize: 24, shadows: <Shadow>[
                  Shadow(
                    // offset: Offset(5, 5),
                    blurRadius: 30,
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ]),
              ),
            ),
          ),
        ),

        // tên tip
        Text(tip.username),
      ],
    );
  }
}
