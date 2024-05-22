import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../colors/color_set.dart';
import '../components/mybutton.dart';
import '../styles/box_shadow.dart';
import 'package:fl_chart/fl_chart.dart';

class ActivityScreen extends StatefulWidget {
  @override
    _ActivityScreenState createState() => _ActivityScreenState();
  }

class _ActivityScreenState extends State<ActivityScreen> {
  double burnedValue = 0;
  double previousBurnedValue = 0;

  List<Map<String, dynamic>> activities = [
    {
      'activityID': 'Running',
      'activityName': 'Running',
      'kcalPerMinute': 10, // Số calo đốt cháy trong 1 phút
      'duration': 0, // Thời gian thực hiện
      'uid': null, // UID của người dùng
    },
    {
      'activityID': 'Cycling',
      'activityName': 'Cycling',
      'kcalPerMinute': 8,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'Swimming',
      'activityName': 'Swimming',
      'kcalPerMinute': 12,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'JumpingRope',
      'activityName': 'Jumping Rope',
      'kcalPerMinute': 15,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'Hiking',
      'activityName': 'Hiking',
      'kcalPerMinute': 7,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'Yoga',
      'activityName': 'Yoga',
      'kcalPerMinute': 5,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'Dancing',
      'activityName': 'Dancing',
      'kcalPerMinute': 9,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'JumpingJacks',
      'activityName': 'Jumping Jacks',
      'kcalPerMinute': 11,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'PushUps',
      'activityName': 'Push-Ups',
      'kcalPerMinute': 6,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'SitUps',
      'activityName': 'Sit-Ups',
      'kcalPerMinute': 7,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'Squats',
      'activityName': 'Squats',
      'kcalPerMinute': 8,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'JumpSquats',
      'activityName': 'Jump Squats',
      'kcalPerMinute': 13,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'Plank',
      'activityName': 'Plank',
      'kcalPerMinute': 4,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'Burpees',
      'activityName': 'Burpees',
      'kcalPerMinute': 14,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'MountainClimbers',
      'activityName': 'Mountain Climbers',
      'kcalPerMinute': 12,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'Lunges',
      'activityName': 'Lunges',
      'kcalPerMinute': 8,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'HighKnees',
      'activityName': 'High Knees',
      'kcalPerMinute': 13,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'Bicycling',
      'activityName': 'Bicycling',
      'kcalPerMinute': 10,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'Rowing',
      'activityName': 'Rowing',
      'kcalPerMinute': 9,
      'duration': 0,
      'uid': null,
    },
    {
      'activityID': 'Boxing',
      'activityName': 'Boxing',
      'kcalPerMinute': 12,
      'duration': 0,
      'uid': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Lấy giá trị burnedValue từ Firestore khi màn hình được khởi tạo
    getBurnedValueFromFirestore();
  }

  // Hàm để lấy giá trị burnedValue từ Firestore
  void getBurnedValueFromFirestore() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? userCurrent = auth.currentUser;
      if (userCurrent != null) {
        String uid = userCurrent.uid;
        DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (snapshot.exists) {
          setState(() {
            burnedValue = snapshot.data()!['burnedValue'] ?? 0;
            previousBurnedValue = burnedValue; // Lưu giá trị đã lưu trước đó
          });
        }
      }
    } catch (e) {
      print('Error getting burned value: $e');
    }
  }

  // Hàm để cập nhật giá trị burnedValue vào Firestore
  void updateBurnedValueToFirestore(double burnedValue) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? userCurrent = auth.currentUser;
      if (userCurrent != null) {
        String uid = userCurrent.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).update({'burnedValue': burnedValue});
        print('Activities updated successfully.');
      }
    } catch (e) {
      print('Error updating activities: $e');
    }
  }

  // Hàm để cập nhật giá trị burnedValue và activities
  void updateBurnedValue() {
    double burned = 0;
    for (var activity in activities) {
      burned += activity['kcalPerMinute'] * activity['duration'];
    }
    setState(() {
      burnedValue = burned + previousBurnedValue; // Cộng với giá trị đã lưu trước đó
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities List'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Cập nhật giá trị burnedValue vào Firestore khi bấm nút Save
              updateBurnedValueToFirestore(burnedValue);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CardHeader(burnedValue: burnedValue),
          Expanded(
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('${activities[index]['activityName']} (${activities[index]['kcalPerMinute']} kcal)'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(labelText: 'Duration (minutes)'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    activities[index]['duration'] = int.tryParse(value) ?? 0;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Button(
                              onTap: () {
                                setState(() {
                                  activities[index]['duration'] = 0;
                                });
                                updateBurnedValue(); // Cập nhật giá trị burnedValue
                              },
                              title: '-',
                              height: 40,
                              width: 40,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Button(
                              onTap: () {
                                // setState(() {
                                //   activities[index]['duration'] += 1; // Increase the duration by 1
                                // });
                                updateBurnedValue(); // Cập nhật giá trị burnedValue
                              },
                              title: '+',
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  final double burnedValue;

  const CardHeader({Key? key, required this.burnedValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Burned: $burnedValue kcal',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
