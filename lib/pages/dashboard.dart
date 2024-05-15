// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app3/components/height_weight_changer.dart';
import 'package:app3/models/recipe.dart';
import 'package:app3/pages/bmi_calculator.dart';
import 'package:app3/pages/list_chat.dart';
import 'package:app3/pages/planpage.dart';
import 'package:app3/pages/recipes.dart';
import 'package:app3/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../colors/color_set.dart';
import '../components/appbar.dart';
import '../components/chartHolder.dart';
import '../components/feature.dart';
import '../components/sidebar.dart';
import '../components/tip2.dart';
import '../components/tip1.dart';

import '../components/tip3.dart';
import '../components/tip4.dart';
import '../components/tip_ball.dart';
import '../components/water_intake.dart';
import '../models/tip_ball.dart';
import '../styles/box_shadow.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final FirestoreService firestoreService = FirestoreService();

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Sidebar(),
        backgroundColor: htaPrimaryColors.shade100,
        body: SafeArea(
          child: Column(
            children: [
              // Phần không cuộn
              Padding(
                padding:
                    EdgeInsets.only(top: 25, bottom: 25, right: 15, left: 15),
                child: FutureBuilder<String?>(
                  future: firestoreService.getCurrentUserEmail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Trả về một widget placeholder nếu future đang loading
                      return CircularProgressIndicator(); // Hoặc bất kỳ widget placeholder nào bạn muốn
                    } else {
                      if (snapshot.hasError) {
                        // Xử lý lỗi nếu có
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Trả về MyAppBar với username khi future đã được giải quyết
                        return MyAppBar(username: snapshot.data ?? 'Unknown'); // Mặc định là 'Unknown' nếu snapshot.data là null
                      }
                    }
                  },
                ),
              ),
              // Cuộn cả Column này
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // story hay tip j đấy (horiz scrollable)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              TipBall(
                                imageUrl:
                                    'https://photos.google.com/u/1/share/AF1QipNAbgiu0dGgFV6-PtY-HRANd7w3fVaykFiq6J-w7Dsew4SApm5Qene0uJc_mQUPNA/photo/AF1QipN8iFY73SaEL4LykuIilIW5kPkCJTlpbDcY5bfm?key=YUZSWkMzdUI0cUk3YTA4YUs1QnBUQjNhajhCUHRB',
                                emoji: '🐅',
                                title: 'Just',
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Tip1Page())),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              TipBall(
                                imageUrl:
                                    'https://photos.google.com/u/1/share/AF1QipNAbgiu0dGgFV6-PtY-HRANd7w3fVaykFiq6J-w7Dsew4SApm5Qene0uJc_mQUPNA/photo/AF1QipMa26UNcfFQoiuZrl8xUgNODCnK98csa8A4kdo3?key=YUZSWkMzdUI0cUk3YTA4YUs1QnBUQjNhajhCUHRB',
                                emoji: '🦊',
                                title: 'Some',
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Tip2Page())),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              TipBall(
                                imageUrl:
                                    'https://photos.google.com/u/1/share/AF1QipNAbgiu0dGgFV6-PtY-HRANd7w3fVaykFiq6J-w7Dsew4SApm5Qene0uJc_mQUPNA/photo/AF1QipP9hAJjZL9wipy3NuCNv0CApZg2Y3rWJIq0TIzs?key=YUZSWkMzdUI0cUk3YTA4YUs1QnBUQjNhajhCUHRB',
                                emoji: '🦆',
                                title: 'Random',
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Tip3Page())),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              TipBall(
                                imageUrl:
                                    'https://photos.google.com/u/1/share/AF1QipNAbgiu0dGgFV6-PtY-HRANd7w3fVaykFiq6J-w7Dsew4SApm5Qene0uJc_mQUPNA/photo/AF1QipMMrDNs7ch3EvZzGVHKD1uNmYa9G7FG65XlfwM9?key=YUZSWkMzdUI0cUk3YTA4YUs1QnBUQjNhajhCUHRB',
                                emoji: '🪳',
                                title: 'Facts',
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Tip4Page())),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              TipBall(
                                imageUrl:
                                    'https://photos.google.com/u/1/share/AF1QipNAbgiu0dGgFV6-PtY-HRANd7w3fVaykFiq6J-w7Dsew4SApm5Qene0uJc_mQUPNA/photo/AF1QipOP7zs4RFvacHhURlLDRGn13LGPGdyAtZn9VJYi?key=YUZSWkMzdUI0cUk3YTA4YUs1QnBUQjNhajhCUHRB',
                                emoji: '🦐',
                                title: 'You',
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              TipBall(
                                imageUrl:
                                    'https://photos.google.com/u/1/share/AF1QipNAbgiu0dGgFV6-PtY-HRANd7w3fVaykFiq6J-w7Dsew4SApm5Qene0uJc_mQUPNA/photo/AF1QipMYH6fLdc4O14Ga8G-_4QFooPSwIMGLokDbIs_H?key=YUZSWkMzdUI0cUk3YTA4YUs1QnBUQjNhajhCUHRB',
                                emoji: '🐬',
                                title: 'Might',
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              TipBall(
                                imageUrl:
                                    'https://photos.google.com/u/1/share/AF1QipNAbgiu0dGgFV6-PtY-HRANd7w3fVaykFiq6J-w7Dsew4SApm5Qene0uJc_mQUPNA/photo/AF1QipM6mcq4w-jQU33N8LRl9NLuLMaj8Yb7iHPCpNXB?key=YUZSWkMzdUI0cUk3YTA4YUs1QnBUQjNhajhCUHRB',
                                emoji: '🦏',
                                title: 'Like',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      // title Your stats today và channge date (?)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Your stats for today',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // mấy cái chart (khó làm quá để sau)
                      ChartHolder(consumedValue: 2000, burnedValue: 500),
                      const SizedBox(
                        height: 25,
                      ),

                      // text how have u changed
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'How have you changed?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // cái box hiển thị cân nặng chiều cao
                      HeightWeightChanger(onUpdate: (p0, p1) {
                        
                      },),
                      SizedBox(
                        height: 25,
                      ),

                      // how much water j j đấy
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'How much water consumed today?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // cái box để hiển thị mấy cái ly nước
                      const WaterIntake(),
                      const SizedBox(
                        height: 25,
                      ),

                      // features
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'More features',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // row gồm mấy cái features khác
                      SingleChildScrollView(
                        clipBehavior: Clip
                            .none, // cái này fix lỗi mấy cái shadows bị clipped mất
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Feature(
                                title: 'BMI Calculator',
                                icon: '🧮',
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const BMI())),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Feature(
                                title: 'Diary',
                                icon: '📓',
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecipePage())),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Feature(
                                title: 'Set goal',
                                icon: '🎯',
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlanPage())),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Feature(
                                title: 'Ask nutritionists',
                                icon: '🧑‍⚕️',
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListChat())),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // padding dưới
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}