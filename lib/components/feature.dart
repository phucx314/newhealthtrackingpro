import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../colors/color_set.dart';
import '../styles/box_shadow.dart';

class Feature extends StatelessWidget {
  Feature({super.key, required this.title, required this.icon,});

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  icon, // này lấy từ model?
                  style: TextStyle(
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
                  title, // này lấy từ model
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
