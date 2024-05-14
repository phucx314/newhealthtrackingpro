// ignore_for_file: prefer_const_constructors

import 'package:app3/colors/color_set.dart';
import 'package:app3/styles/box_shadow.dart';
import 'package:flutter/material.dart';



class WaterConsumedHistory extends StatefulWidget {
  @override
  State<WaterConsumedHistory> createState() => _WaterConsumedHistoryState();
}

class _WaterConsumedHistoryState extends State<WaterConsumedHistory> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 0.1,
      maxChildSize: 1,
      snap: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 50,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Draggable Bottom Sheet',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 50,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Item $index'),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}