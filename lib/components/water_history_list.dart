import 'dart:convert';
import 'package:app3/components/history_item.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  List<Map<Object, dynamic>> historyData = [
    {
      "historyID": "20240507",
      "consumptionAmount": 2000,
      "date": "Tue - May 07, 2024"
    },
    {
      "historyID": "20240508",
      "consumptionAmount": 1250,
      "date": "Wed - May 08, 2024"
    },
    {
    "historyID": "20240509",
    "consumptionAmount": 1897,
    "date": "Thu - May 09, 2024"
  },
  {
    "historyID": "20240510",
    "consumptionAmount": 727,
    "date": "Fri - May 10, 2024"
  },
  {
    "historyID": "20240511",
    "consumptionAmount": 1549,
    "date": "Sat - May 11, 2024"
  },
  {
    "historyID": "20240512",
    "consumptionAmount": 295,
    "date": "Sun - May 12, 2024"
  },
  {
    "historyID": "20240513",
    "consumptionAmount": 1229,
    "date": "Mon - May 13, 2024"
  },
  {
    "historyID": "20240514",
    "consumptionAmount": 1763,
    "date": "Tue - May 14, 2024"
  },
  {
    "historyID": "20240515",
    "consumptionAmount": 850,
    "date": "Wed - May 15, 2024"
  },
  {
    "historyID": "20240516",
    "consumptionAmount": 3913,
    "date": "Thu - May 16, 2024"
  },
  {
    "historyID": "20240517",
    "consumptionAmount": 2275,
    "date": "Fri - May 17, 2024"
  },
  {
    "historyID": "20240518",
    "consumptionAmount": 1734,
    "date": "Sat - May 18, 2024"
  },
  {
    "historyID": "20240519",
    "consumptionAmount": 2282,
    "date": "Sun - May 19, 2024"
  },
  {
    "historyID": "20240520",
    "consumptionAmount": 1864,
    "date": "Mon - May 20, 2024"
  },
  {
    "historyID": "20240521",
    "consumptionAmount": 316,
    "date": "Tue - May 21, 2024"
  },
  {
    "historyID": "20240522",
    "consumptionAmount": 2131,
    "date": "Wed - May 22, 2024"
  }
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: historyData.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            HistoryItem(
              date: historyData[index]['date'],
              consumptionAmount: historyData[index]['consumptionAmount'],
              historyItemID: historyData[index]['historyID'],
            ),
            SizedBox(height: 10,),
          ],
        );
      },
    );
  }
}
