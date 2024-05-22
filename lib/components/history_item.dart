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
    // required this.evaluateStatus,
    // required this.evaluateColor,
    required this.consumptionAmount,
  });

  final historyItemID;
  final String date;
  // final String evaluateStatus;
  // final Color evaluateColor;
  final int consumptionAmount;

  String evaluateStt(int consumptionAmount) {
    if(consumptionAmount >= 2000) return 'Good';
    else if(consumptionAmount < 2000 && consumptionAmount >= 1500) return 'Moderate';
    else return 'Bad';
  }

  Color evaluateClr(int consumptionAmount) {
    if(consumptionAmount >= 2000) return htaStatusColors.shade200;
    else if(consumptionAmount < 2000 && consumptionAmount >= 1500) return htaStatusColors.shade400;
    else return htaStatusColors.shade600;
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Text thứ ngày và trạng thái đánh giá
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                evaluateStt(consumptionAmount),
              ),
            ],
          ),
        ),
        SizedBox(width: 10,),
        
        // Container màu trạng thái đánh giá
        Expanded(
          flex: 0,
          child: Container(
            width: 5,
            height: 60,
            decoration: BoxDecoration(
              color: evaluateClr(consumptionAmount),
              borderRadius: BorderRadius.circular(5/2),
            ),
          ),
        ),
        
        SizedBox(width: 10,),
        
        // Text 'You have consumed' và số liệu consumed
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You have consumed',
              ),
              Text(
                '${(consumptionAmount).toString()} ml',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );

  }
}