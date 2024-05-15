import 'package:app3/components/appbar.dart';
import 'package:app3/components/planCard.dart';
import 'package:app3/components/sidebar.dart';
import 'package:app3/models/newsRecipe.dart'; // Adjust import if needed
import 'package:app3/models/plan.dart';
import 'package:app3/models/recipe.dart';
import 'package:app3/services/auth_service.dart';
import 'package:app3/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../colors/color_set.dart';
import '../components/button.dart';
import '../components/input_plan.dart';
import '../components/input_recipes.dart';
import '../components/recipes_card.dart';

class PlanPage extends StatelessWidget {
  PlanPage({super.key, this.createNewPlan, this.goToRecipe});
  final FirestoreService firestoreService = FirestoreService();
  final void Function()? createNewPlan;
  final void Function()? goToRecipe;
  void openDashboard(BuildContext context) {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: htaPrimaryColors.shade100,
        drawer: Sidebar(),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
                child: MyAppBar(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: MyButton(
                            onTap: goToRecipe,
                            title: "Recipes",
                            width: 170,
                            left: 0,
                            right: 5,
                            color: Colors.white,
                            textColor: const Color(0xFF4D8BAA),
                            borderRadius: 10,
                          ),
                        ),
                        Expanded(
                          child: MyButton(
                            onTap: () {
                              // Handle Favorites button tap
                            },
                            title: "Plan",
                            width: 170,
                            left: 5,
                            right: 0,
                            borderRadius: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display RecipesCards from newsRecipe
                        Wrap(
                          spacing: 0, // Khoảng cách giữa các thẻ
                          runSpacing: 0, // Khoảng cách giữa các dòng
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () =>
                                                openDashboard(context),
                                            icon: const Icon(Icons.info),
                                            iconSize: 25,
                                            color: const Color(0xFF4D8BAA),
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Find a plan",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(25, 0, 25, 0),
                                      child: Text(
                                        "Meal plans, workout plans, and more. Start a plan, follow along, and reach your goals.",
                                        style: TextStyle(
                                          color: Color(0xFF4D8BAA),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: firestoreService.getPlansStream(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<QueryDocumentSnapshot> plansList =
                                      snapshot.data!.docs;

                                  return Wrap(
                                    spacing: 0,
                                    runSpacing: 10,
                                    children: plansList.map((document) {
                                      Plan plan = Plan(
                                        id: document['id'],
                                        description: document['description'],
                                        imagePath: document['imagePath'],
                                        timeFund: document['timeFund'],
                                        status: document['status'],
                                        dateCreate:
                                            document['dateCreate'].toDate(),
                                      );

                                      return PlanCard(plan: plan);
                                    }).toList(),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .end, // Đảm bảo các thành phần trong hàng được căn phải
                              children: [
                                MyButton(
                                  onTap: () {
                                    //su dung cai nay de den voi trang dang gap loi
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Inputplans(),
                                      ),
                                    );
                                    // su dung newsRecipe cai nay chi de tesst
                                    // newsRecipe
                                    //     .addRecipesToFirestore(newsRecipe.menu);
                                  },
                                  title: "New plan",
                                  width: screenSize.width * 0.425,
                                  left: 0,
                                  right:
                                      0, // Đặt khoảng cách bên phải là 0 để nút nằm bên phải
                                  color: const Color(0xFF4D8BAA),
                                  borderRadius: 30,
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
            ],
          ),
        ),
      ),
    );
  }
}
