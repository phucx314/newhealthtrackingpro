// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../colors/color_set.dart';
import '../components/appbar.dart';
import '../components/button.dart';
import '../components/mybutton.dart';
import '../components/sidebar.dart';
import '../components/text_field.dart';
import '../styles/box_shadow.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final TextEditingController heightCtrl = TextEditingController();
  final TextEditingController weightCtrl = TextEditingController();
  final TextEditingController genderCtrl = TextEditingController();
  TextEditingController bmiCtrl = TextEditingController();

  var bmi;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Sidebar(),
        backgroundColor: htaPrimaryColors.shade100,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  //appbar
                  MyAppBar(username: 'username'),

                  SizedBox(
                    height: 25,
                  ),
                  // Text
                  Center(
                    child: Text(
                      'BMI Calculator',
                      style: TextStyle(
                        color: htaPrimaryColors.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  // container chua input
                  Container(
                    decoration: BoxDecoration(
                      color: htaPrimaryColors.shade50,
                      borderRadius: BorderRadius.circular(
                          15 + 15), // +15 vi padding 15 nen bo goc them 15 do
                      boxShadow: [
                        shadow,
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          // textfields
                          MyTextField(
                            controller: heightCtrl,
                            hintText: 'Your height',
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MyTextField(
                            controller: weightCtrl,
                            hintText: 'Your weight',
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MyTextField(
                            controller: genderCtrl,
                            hintText: 'Your gender',
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          // button
                          Align(
                            alignment: Alignment.centerRight,
                            child: MyButton(
                              onTap: getBMI,
                              title: 'Calculate',
                              width:
                                  (MediaQuery.of(context).size.width - 50) / 2,
                              left: 0,
                              right: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  // container chua ket qua
                  Container(
                    decoration: BoxDecoration(
                      color: htaPrimaryColors.shade50,
                      borderRadius: BorderRadius.circular(
                          15 + 15), // +15 vi padding 15 nen bo goc them 15 do
                      boxShadow: [
                        shadow,
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          // textfields
                          MyTextField(
                            controller: bmiCtrl,
                            hintText: 'Your BMI',
                            obscureText: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          // text status
                          Align(
                            alignment: Alignment.centerLeft,
                            child: bmiCtrl.text.isNotEmpty
                                ? Text(
                                    'You\'re in ${status()}',
                                    style: TextStyle(
                                      color: htaPrimaryColors.shade500,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : SizedBox(), // Nếu trường BMI chưa có dữ liệu, không hiển thị gì cả
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          // button
                          Align(
                            alignment: Alignment.centerRight,
                            child: Button(
                              onTap: () {},
                              title: 'Find you plan',
                              width:
                                  (MediaQuery.of(context).size.width - 50) / 2,
                              color: htaPrimaryColors.shade50,
                              textColor: htaPrimaryColors.shade500,
                              borderColor: htaPrimaryColors.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getBMI() {
    var getHeight = double.parse(heightCtrl.text) / 100;
    var getWeight = double.parse(weightCtrl.text);
    if (getWeight > 0 && getHeight > 0) {
      setState(() {
        bmi = getWeight / (getHeight * getHeight);
        bmiCtrl.text = bmi.toString();
      });
    } else {
      setState(() {
        bmiCtrl.text = 'not valid values';
        bmi = bmiCtrl.text;
      });
    }
  }

  String status() {
    if (bmi == null) {
      return '';
    }
    if (bmi == 'not valid values') {
      return '???';
    } else if (bmi < 18.5)
      return 'underweight';
    else if (bmi >= 18.5 && bmi < 23)
      return 'normal';
    else if (bmi >= 23 && bmi < 25)
      return 'overweight';
    else
      return 'obese';
  }
}
