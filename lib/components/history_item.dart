// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app3/colors/color_set.dart';
import 'package:app3/models/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HistoryItem extends StatelessWidget {
  HistoryItem({
    super.key,
    this.historyItemID,
    required this.date,
    required this.evaluateStatus,
    required this.evaluateColor,
    required this.consumptionAmount,
  });

  final historyItemID;
  final String date;
  final String evaluateStatus;
  final Color evaluateColor;
  final int consumptionAmount;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // thứ ngày
            Text(
              date,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            // trạng thái đánh giá
            Text(
              evaluateStatus,
            ),
          ],
        ),
        SizedBox(width: 10,),

        // màu trạng thái đánh giá
        Container(
          height: 60, 
          width: 5, 
          decoration: BoxDecoration(
            color: evaluateColor,
            borderRadius: BorderRadius.circular(5/2),
          ),
        ),

        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // text
            Text(
              'You have consumed',
            ),
            // số liệu consumed
            Text(
              consumptionAmount.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
}