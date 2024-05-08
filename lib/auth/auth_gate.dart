import 'package:app3/pages/dashboard.dart';
import 'package:app3/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup_or_login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return const Dashboard();
          }
          //user is not logged in
          else {
            return const SignupOrLogin();
          }
        },
      ),
    );
  }
}
