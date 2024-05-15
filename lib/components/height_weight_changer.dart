// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app3/colors/color_set.dart';
import 'package:app3/styles/box_shadow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HeightWeightChanger extends StatefulWidget {
  HeightWeightChanger({super.key, required this.onUpdate});

  final Function(double, double) onUpdate;

  // Định nghĩa phương thức updateUserInfo ở đây
  Future<void> updateUserInfo(double newHeight, double newWeight) async {
    // Lấy thông tin user hiện tại
    FirebaseAuth auth = FirebaseAuth.instance;
    User? userCurrent = auth.currentUser;

    if (userCurrent != null) {
      String uid = userCurrent.uid;

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({
          'height': newHeight,
          'weight': newWeight,
        });
        print('User information updated successfully.');
      } catch (e) {
        print('Error updating user information: $e');
      }
    } else {
      print('No user is currently signed in.');
    }
  }

  @override
  State<HeightWeightChanger> createState() => _HeightWeightChangerState();
}

class _HeightWeightChangerState extends State<HeightWeightChanger> {
  double height = 0; // Khởi tạo giá trị height
  double weight = 0; // Khởi tạo giá trị weight

  @override
  void initState() {
    super.initState();
    getDataFromFirestore(); // Gọi phương thức để lấy dữ liệu từ Firestore khi widget được khởi tạo
  }

  Future<void> getDataFromFirestore() async {
    // Lấy dữ liệu từ Firestore
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? userCurrent = auth.currentUser;
      if (userCurrent != null) {
        String uid = userCurrent.uid;
        DocumentSnapshot userSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          setState(() {
            height = userData['height'] != null ? userData['height'].toDouble() : 0;
            weight = userData['weight'] != null ? userData['weight'].toDouble() : 0;
          });
        }
      }
    } catch (e) {
      print('Error fetching data from Firestore: $e');
    }
  }

  void gainH() {
    setState(() {
      height += 0.1;
      updateFirestoreData();
    });
  }

  void loseH() {
    setState(() {
      height -= 0.1;
      updateFirestoreData();
    });
  }

  void gainW() {
    setState(() {
      weight += 0.1;
      updateFirestoreData();
    });
  }

  void loseW() {
    setState(() {
      weight -= 0.1;
      updateFirestoreData();
    });
  }

  void updateFirestoreData() {
    // Lấy thông tin user hiện tại
    FirebaseAuth auth = FirebaseAuth.instance;
    User? userCurrent = auth.currentUser;

    if (userCurrent != null) {
      String uid = userCurrent.uid;

      // Tạo map mới chứa dữ liệu height và weight
      Map<String, dynamic> newData = {
        'height': height,
        'weight': weight,
      };

      // Gọi hàm cập nhật thông tin user lên Firestore
      widget.updateUserInfo(height, weight);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: htaPrimaryColors.shade50,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [shadow,],
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Text(
                'Height',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // dấu trừ
                  GestureDetector(
                    onTap: () {
                      loseH();
                    },
                    child: Image(image: AssetImage('assets/icons/btn_minus.png'), height: 60, width: 60,),
                  ),

                  Text(
                    '$height cm',
                    style: TextStyle(color: htaPrimaryColors.shade500,),
                  ),

                  // dấu cộng
                  GestureDetector(
                    onTap: () {
                      gainH();
                    },
                    child: Image(image: AssetImage('assets/icons/btn_plus.png'), height: 60, width: 60,),
                  ),
                ],
              ),
              SizedBox(height: 15,),

              Text(
                'Weight',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // dấu trừ
                  GestureDetector(
                    onTap: () {
                      loseW();
                    },
                    child: Image(image: AssetImage('assets/icons/btn_minus.png'), height: 60, width: 60,),
                  ),

                  Text(
                    '$weight kg',
                    style: TextStyle(color: htaPrimaryColors.shade500,),
                  ),

                  // dấu cộng
                  GestureDetector(
                    onTap: () {
                      gainW();
                    },
                    child: Image(image: AssetImage('assets/icons/btn_plus.png'), height: 60, width: 60,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}