import 'package:app3/pages/planpage.dart';
import 'package:app3/pages/recipes.dart';
import 'package:flutter/material.dart';
import '../pages/signin.dart';
import '../pages/signup.dart';

class PlanOrRecipe extends StatefulWidget {
  const PlanOrRecipe({super.key});

  @override
  State<PlanOrRecipe> createState() => _PlanOrRecipeState();
}

class _PlanOrRecipeState extends State<PlanOrRecipe> {
  //initially, show login page
  bool showPlanPage = true;
  //toggle between login and register page
  void togglePages() {
    setState(() {
      showPlanPage = !showPlanPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showPlanPage) {
      return PlanPage(
        goToRecipe: togglePages,
      );
    } else {
      return RecipePage(
        goToPlan: togglePages,
      );
    }
  }
}
