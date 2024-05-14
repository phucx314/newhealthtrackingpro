// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app3/colors/color_set.dart';
import 'package:app3/components/history_item.dart';
import 'package:app3/models/history_item.dart';
import 'package:app3/components/water_history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WaterHistory extends StatefulWidget {
  WaterHistory({super.key});

  @override
  State<WaterHistory> createState() => _WaterHistoryState();
}

class _WaterHistoryState extends State<WaterHistory> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: htaPrimaryColors.shade100,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: 25,),
                // tiêu đề
                Center(
                  child: Text(
                    'Water consumed history',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                // items
                Expanded(
                  child: HistoryList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}