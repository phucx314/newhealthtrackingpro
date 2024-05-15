import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../colors/color_set.dart';
import '../components/mybutton.dart';
import '../styles/box_shadow.dart';
import 'package:fl_chart/fl_chart.dart';

class FoodScreen extends StatefulWidget {
  @override
    _FoodScreenState createState() => _FoodScreenState();
  }

class _FoodScreenState extends State<FoodScreen> {
  double consumedValue = 0;
  double burnedValue = 0;
  double previousConsumedValue = 0; // Giá trị đã lưu trước đó

  List<Map<String, dynamic>> foods = [
    {'name': 'Water', 'quantity': 0, 'calories': 0, 'unit': 'cup', 'foodId': 'Water0', 'uid': null},
    {'name': 'Green Tea', 'quantity': 0, 'calories': 0, 'unit': 'cup', 'foodId': 'GreenTea0', 'uid': null},
    {'name': 'Black Tea', 'quantity': 0, 'calories': 2, 'unit': 'cup', 'foodId': 'BlackTea2', 'uid': null},
    {'name': 'Coffee', 'quantity': 0, 'calories': 2, 'unit': 'cup', 'foodId': 'Coffee2', 'uid': null},
    {'name': 'Latte', 'quantity': 0, 'calories': 120, 'unit': 'cup', 'foodId': 'Latte120', 'uid': null},
    {'name': 'Cappuccino', 'quantity': 0, 'calories': 74, 'unit': 'cup', 'foodId': 'Cappuccino74', 'uid': null},
    {'name': 'Espresso', 'quantity': 0, 'calories': 3, 'unit': 'cup', 'foodId': 'Espresso3', 'uid': null},
    {'name': 'Hot Chocolate', 'quantity': 0, 'calories': 192, 'unit': 'cup', 'foodId': 'HotChocolate192', 'uid': null},
    {'name': 'Orange Juice', 'quantity': 0, 'calories': 112, 'unit': 'cup', 'foodId': 'OrangeJuice112', 'uid': null},
    {'name': 'Apple Juice', 'quantity': 0, 'calories': 114, 'unit': 'cup', 'foodId': 'AppleJuice114', 'uid': null},
    {'name': 'Grapefruit Juice', 'quantity': 0, 'calories': 96, 'unit': 'cup', 'foodId': 'GrapefruitJuice96', 'uid': null},
    {'name': 'Lemonade', 'quantity': 0, 'calories': 99, 'unit': 'cup', 'foodId': 'Lemonade99', 'uid': null},
    {'name': 'Cranberry Juice', 'quantity': 0, 'calories': 116, 'unit': 'cup', 'foodId': 'CranberryJuice116', 'uid': null},
    {'name': 'Pineapple Juice', 'quantity': 0, 'calories': 133, 'unit': 'cup', 'foodId': 'PineappleJuice133', 'uid': null},
    {'name': 'Coconut Water', 'quantity': 0, 'calories': 46, 'unit': 'cup', 'foodId': 'CoconutWater46', 'uid': null},
    {'name': 'Almond Milk', 'quantity': 0, 'calories': 39, 'unit': 'cup', 'foodId': 'AlmondMilk39', 'uid': null},
    {'name': 'Soy Milk', 'quantity': 0, 'calories': 80, 'unit': 'cup', 'foodId': 'SoyMilk80', 'uid': null},
    {'name': 'Rice Milk', 'quantity': 0, 'calories': 120, 'unit': 'cup', 'foodId': 'RiceMilk120', 'uid': null},
    {'name': 'Beer', 'quantity': 0, 'calories': 153, 'unit': 'can', 'foodId': 'Beer153', 'uid': null},
    {'name': 'Wine', 'quantity': 0, 'calories': 125, 'unit': 'glass', 'foodId': 'Wine125', 'uid': null},
  ];

  @override
  void initState() {
    super.initState();
    // Lấy giá trị consumedValue từ Firestore khi màn hình được khởi tạo
    getConsumedValueFromFirestore();
  }

  // Hàm để lấy giá trị consumedValue từ Firestore
  void getConsumedValueFromFirestore() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? userCurrent = auth.currentUser;
      if (userCurrent != null) {
        String uid = userCurrent.uid;
        DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (snapshot.exists) {
          setState(() {
            consumedValue = snapshot.data()!['consumedValue'] ?? 0;
            previousConsumedValue = consumedValue; // Lưu giá trị đã lưu trước đó
          });
        }
      }
    } catch (e) {
      print('Error getting consumed value: $e');
    }
  }

  // Hàm để cập nhật giá trị consumedValue vào Firestore
  void updateConsumedValueToFirestore(double consumedValue) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? userCurrent = auth.currentUser;
      if (userCurrent != null) {
        String uid = userCurrent.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).update({'consumedValue': consumedValue});
        print('Consumed value updated successfully.');
      }
    } catch (e) {
      print('Error updating consumed value: $e');
    }
  }

  // Hàm để cập nhật giá trị consumedValue và foods
  void updateConsumedValue() {
    double consumed = 0;
    for (var food in foods) {
      consumed += food['calories'] * food['quantity'];
    }
    setState(() {
      consumedValue = consumed + previousConsumedValue; // Cộng với giá trị đã lưu trước đó
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food List'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Cập nhật giá trị consumedValue vào Firestore khi bấm nút Save
              updateConsumedValueToFirestore(consumedValue);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CardHeader(consumedValue: consumedValue),
          Expanded(
            child: ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('${foods[index]['name']} (${foods[index]['calories']} kcal)'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(labelText: 'Quantity (${foods[index]['unit']})'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    foods[index]['quantity'] = int.tryParse(value) ?? 0;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Button(
                              onTap: () {
                                setState(() {
                                  foods[index]['quantity'] = 0;
                                });
                                updateConsumedValue();
                              },
                              title: '-',
                              height: 40,
                              width: 40,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Button(
                              onTap: () {
                                updateConsumedValue();
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
  final double consumedValue;

  const CardHeader({Key? key, required this.consumedValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Consumed: $consumedValue kcal',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
