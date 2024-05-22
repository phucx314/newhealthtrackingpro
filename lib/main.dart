import 'package:app3/auth/plan_or_recipes.dart';
import 'package:app3/auth/signup_or_login.dart';
import 'package:app3/firebase_options.dart';
import 'package:app3/pages/dashboard.dart';
import 'package:app3/pages/home_page.dart';
import 'package:app3/pages/not_this.dart';
import 'package:app3/pages/planpage.dart';
import 'package:app3/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/auth_gate.dart';
import 'pages/recipes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const NotThis());
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
