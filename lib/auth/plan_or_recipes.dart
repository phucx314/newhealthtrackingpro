import 'package:app3/pages/planpage.dart';
import 'package:app3/pages/recipes.dart';
import 'package:flutter/material.dart';
import '../pages/signin.dart';
import '../pages/signup.dart';

class PlanOrRecipe extends StatefulWidget {
  const PlanOrRecipe({super.key, required this.show});
  final bool show;

  @override
  State<PlanOrRecipe> createState() => _PlanOrRecipeState();
}

class _PlanOrRecipeState extends State<PlanOrRecipe> {
  bool showPlanPage = true;

  void togglePages() {
    setState(() {
      showPlanPage = !showPlanPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.show) {
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
