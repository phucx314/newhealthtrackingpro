import 'package:app3/auth/plan_or_recipes.dart';
import 'package:app3/auth/signup_or_login.dart';
import 'package:app3/firebase_options.dart';
import 'package:app3/pages/dashboard.dart';
import 'package:app3/pages/home_page.dart';
import 'package:app3/pages/planpage.dart';
import 'package:app3/pages/signup.dart';
import 'package:app3/test_data/testfood.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/auth_gate.dart';
import 'components/tip1.dart';
import 'components/tip2.dart';
import 'components/tip3.dart';
import 'components/tip4.dart';
import 'pages/recipes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // addFoodsToFirestore();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: PlanOrRecipe(),
      home: AuthGate(),
    );
  }
}
