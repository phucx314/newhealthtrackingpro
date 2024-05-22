import 'package:app3/components/history_item.dart';
import 'package:flutter/material.dart';
import '../services/firestore.dart';

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  List<Map<String, dynamic>> historyData = [];
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _fetchHistoryData();
  }

  Future<void> _fetchHistoryData() async {
    String? uid = await firestoreService.getCurrentUserUID();
    if (uid != null) {
      List<Map<String, dynamic>> data = await firestoreService.getWaterHistory(uid);
      setState(() {
        historyData = data;
      });
    } else {
      // Handle user not logged in
    }
  }

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
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
