import 'package:flutter/material.dart';
import '../pages/signin.dart';
import '../pages/signup.dart';

class SignupOrLogin extends StatefulWidget {
  const SignupOrLogin({super.key});

  @override
  State<SignupOrLogin> createState() => _SignupOrLoginState();
}

class _SignupOrLoginState extends State<SignupOrLogin> {
  //initially, show login page
  bool showLoginPage = true;
  //toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Signin(
        goToSignUp: togglePages,
      );
    } else {
      return SignUp(
        goToSignIn: togglePages,
      );
    }
  }
}
