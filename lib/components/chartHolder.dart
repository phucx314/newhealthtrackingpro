import 'package:app3/components/mybutton.dart';
import 'package:app3/pages/food_scr.dart';
import 'package:app3/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../colors/color_set.dart';
import '../pages/activ_screen.dart';
import '../styles/box_shadow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChartHolder extends StatefulWidget {
  ChartHolder({Key? key, required this.consumedValue, required this.burnedValue});

  final double consumedValue;
  final double burnedValue;

  @override
  State<ChartHolder> createState() => _ChartHolderState();
}

class _ChartHolderState extends State<ChartHolder> {

  final FirestoreService firestoreService = FirestoreService();

  // Hàm để cập nhật consumedValue vào Firestore
  Future<void> saveConsumedValueToFirestore(double consumedValue) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? userCurrent = auth.currentUser;
      if (userCurrent != null) {
        final String uid = userCurrent.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'consumedValue': consumedValue});
        print('Consumed value updated successfully.');
      }
    } catch (e) {
      print('Error updating consumed value: $e');
    }
  }

  double consumedValue = 0; // Khởi tạo consumedValue
  double burnedValue = 0;

  @override
  void initState() {
    // Gọi hàm fetchDataFromFirestore khi widget được khởi tạo
    _fetchDataFromFirestore();
    super.initState();
  }

  // Hàm để fetch dữ liệu từ Firestore
  Future<void> _fetchDataFromFirestore() async {
    try {
      final String? currentUid = await firestoreService.getCurrentUserUID();
      if (currentUid != null) {
        final String uid = currentUid;
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        // Lấy giá trị consumedValue từ snapshot và cập nhật vào state
        setState(() {
          consumedValue = snapshot.data()?['consumedValue'] ?? 0;
        });
      }
    } catch (e) {
      print('Error fetching data from Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: firestoreService.getCurrentUserUID(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final String? uid = snapshot.data;
        if (uid == null) {
          return Text('User not logged in');
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            decoration: BoxDecoration(
              color: htaPrimaryColors.shade50,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [shadow],
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Calories
                const Text(
                  'Calories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // pie charts
                SizedBox(
                  height: 110, // Đã sửa lại từ 1110
                  child: Row(
                    children: [
                      // chỗ này là số kcal đã hấp thụ
                      Expanded(
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text("Loading");
                            }

                            final Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;
                            consumedValue = data?['consumedValue'] ?? 0;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // số
                                Text(
                                  '${(consumedValue).truncate()}',
                                  style: TextStyle(
                                    color: htaPrimaryColors.shade500,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                                // chữ
                                Text(
                                  'kcal consumed',
                                  style: TextStyle(
                                    color: htaPrimaryColors.shade500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      // chỗ này là cái pie chart remaining kcal
                      Expanded(
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text("Loading");
                            }

                            final Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;
                            consumedValue = data?['consumedValue'] ?? 0;
                            burnedValue = data?['burnedValue'] ?? 0;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 110 -
                                      10, // Chiều cao cố định - đi radius
                                  width: 110 -
                                      10, // Chiều rộng cố định - đi radius
                                  child: PieChart(
                                    PieChartData(
                                      startDegreeOffset: -90,
                                      sections: [
                                        PieChartSectionData(
                                          color: htaPrimaryColors
                                              .shade200,
                                          value: consumedValue - burnedValue,
                                          radius: 10,
                                          title: '',
                                        ),
                                        PieChartSectionData(
                                          color: htaPrimaryColors
                                              .shade500,
                                          value: burnedValue,
                                          title: '',
                                          radius: 10,
                                        ),
                                      ],
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 35,
                                    ),
                                  ),
                                ),
                            
                                // số
                                Text(
                                  textAlign: TextAlign.center,
                                  '${(consumedValue-burnedValue).truncate()}' '\nremaining',
                                  style: TextStyle(
                                    color: htaPrimaryColors.shade500,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          }
                        ),
                      ),

                      // chỗ này là số kcal đã đốt
                      Expanded(
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text("Loading");
                            }

                            final Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;
                            burnedValue = data?['burnedValue'] ?? 0;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // số
                                Text(
                                  '${burnedValue.truncate()}',
                                  style: TextStyle(
                                    color: htaPrimaryColors.shade500,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                                // chữ
                                Text(
                                  'kcal burned',
                                  style: TextStyle(
                                    color: htaPrimaryColors.shade500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                
                // add consumptions hoặc burn
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Button(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FoodScreen()),
                          );
                        }, 
                        title: 'Add calories',
                        height: 40,
                        color: htaPrimaryColors.shade50,
                        borderColor: htaPrimaryColors.shade500,
                        textColor: htaPrimaryColors.shade500,
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Button(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ActivityScreen()),
                          );
                        }, 
                        title: 'Burn calories',
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}