import 'package:flutter/material.dart';

class HistoryItemModel {
  final historyItemID;
  final String date;
  final String evaluateStatus;
  final Color evaluateColor;
  final String constText = 'You have consumed';
  final int consumptionAmount;

  HistoryItemModel({
    required this.date, 
    required this.evaluateStatus, 
    required this.evaluateColor, 
    required this.consumptionAmount, 
    required this.historyItemID,
  });
}