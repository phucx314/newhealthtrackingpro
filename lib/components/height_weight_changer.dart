// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app3/colors/color_set.dart';
import 'package:app3/styles/box_shadow.dart';
import 'package:flutter/material.dart';

class HeightWeightChanger extends StatefulWidget {
  HeightWeightChanger({super.key});

  @override
  State<HeightWeightChanger> createState() => _HeightWeightChangerState();
}

class _HeightWeightChangerState extends State<HeightWeightChanger> {

  double height = 165; // init value thôi, sau đưa data từ db vào
  double weight = 54;  // init value thôi, sau đưa data từ db vào

  void gainH() {
    setState(() {
      height += 0.5;
    });
  }

  void loseH() {
    setState(() {
      height -= 0.5;
    });
  }

  void gainW() {
    setState(() {
      weight += 0.5;
    });
  }

  void loseW() {
    setState(() {
      weight -= 0.5;
    });
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
                    '$height kg',
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