// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../colors/color_set.dart';
import '../components/button.dart';
import '../components/header_text.dart';
import '../components/text_field.dart';
import '../services/auth_service.dart';
import '../styles/box_shadow.dart';

class Signin extends StatelessWidget {
  Signin({super.key, this.goToSignUp});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final void Function()? goToSignUp;
  void signIn(BuildContext context) async {
    // Your login logic here
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
          usernameController.text, passwordController.text);
    } catch (e) {
      showDialog(
          // context: context,
          // builder: (context) => AlertDialog(
          //   title: Text(e.toString()),
          // ),
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Please enter your user name and password!"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final isKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            extendBody: true,
            backgroundColor: htaPrimaryColors.shade100,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // cái ô trắng làm nền cho 2 options Đăng nhập và Đnăg ký
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          height: 60,
                          margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                          decoration: BoxDecoration(
                            boxShadow: [
                              shadow,
                            ],
                            borderRadius: BorderRadius.circular(15),
                            color: htaPrimaryColors.shade50,
                          ),
                          child: Row(
                            children: [
                              // nút Đăng nhập
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          Size.fromHeight(50)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              htaPrimaryColors.shade500),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              htaPrimaryColors.shade50),
                                      shape: MaterialStateProperty.resolveWith<
                                          OutlinedBorder?>(
                                        (Set<MaterialState> states) {
                                          return RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          );
                                        },
                                      ),
                                    ),
                                    onPressed: null,
                                    child: Text('Sign in'),
                                  ),
                                ),
                              ),

                              // Nút đăng ký
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          Size.fromHeight(50)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              htaPrimaryColors.shade50),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              htaPrimaryColors.shade50),
                                      shape: MaterialStateProperty.resolveWith<
                                          OutlinedBorder?>(
                                        (Set<MaterialState> states) {
                                          return RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          );
                                        },
                                      ),
                                    ),
                                    onPressed: goToSignUp,
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                        color: htaPrimaryColors.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),

                    // SizedBox(
                    //   height: 25,
                    // ),

                    // ảnh gì đấy
                    Container(
                      height: 400,
                      padding: EdgeInsets.all(50),
                      child: Image(
                        image: AssetImage('assets/images/app_logo_pic.png'),
                      ),
                    ),

                    // SizedBox(
                    //   height: 25,
                    // ),

                    // vùng để nhập thông tin đăng nhập
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 25, left: 25, right: 25),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Text
                            MyHeaderText(
                              text: 'Sign in',
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            // ô username
                            MyTextField(
                              controller: usernameController,
                              hintText: "Your username",
                              obscureText: false,
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            // ô pass
                            MyTextField(
                              controller: passwordController,
                              hintText: "Your password",
                              obscureText: true,
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            // forgot pass?
                            Text(
                              'Forgot password?',
                              textAlign: TextAlign.right,
                              style:
                                  TextStyle(color: htaPrimaryColors.shade500),
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            // sign in button
                            MyButton(
                                onTap: () => signIn(context),
                                title: 'Sign in',
                                width: 200,
                                left: 1,
                                right: 1),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
