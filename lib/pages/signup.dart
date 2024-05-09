import 'package:flutter/material.dart';
import '../colors/color_set.dart';
import '../components/button.dart';
import '../components/header_text.dart';
import '../components/text_field.dart';
import '../services/auth_service.dart';
import '../styles/box_shadow.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key, this.goToSignIn});

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final void Function()? goToSignIn;

  void signUp(BuildContext context) {
    // Pass BuildContext as an argument
    final auth = AuthService();

    //password match -> create user
    if (passwordController.text == confirmPasswordController.text) {
      try {
        auth.signUpWithEmailPassword(emailController.text,
            passwordController.text, fullnameController.text);
      } catch (e) {
        showDialog(
            // context: context, // Use the provided BuildContext
            // builder: (context) => AlertDialog(
            //   title: Text(e.toString()),
            // ),
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Please fill all your information"),
                ));
      }
    }
    //password dont match -> show error to user
    else {
      showDialog(
        context: context, // Use the provided BuildContext
        builder: (context) => const AlertDialog(
          title: Text("Password don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                        margin:
                            const EdgeInsets.only(top: 25, left: 25, right: 25),
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
                                        const Size.fromHeight(50)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            htaPrimaryColors.shade50),
                                    foregroundColor: MaterialStateProperty.all(
                                        htaPrimaryColors.shade500),
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
                                  onPressed: goToSignIn,
                                  child: const Text('Sign in'),
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
                                        const Size.fromHeight(50)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            htaPrimaryColors.shade500),
                                    foregroundColor: MaterialStateProperty.all(
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
                                  onPressed: () {
                                    //
                                  },
                                  child: const Text(
                                    'Sign up',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  // vùng để nhập thông tin đăng ký
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 25, left: 25, right: 25),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Text
                          const MyHeaderText(
                            text: 'Create account',
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          MyTextField(
                            controller: fullnameController,
                            hintText: "Full name",
                            obscureText: false,
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          MyTextField(
                            controller: emailController,
                            hintText: "Email",
                            obscureText: false,
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          // ô username
                          MyTextField(
                            controller: passwordController,
                            hintText: "Password",
                            obscureText: false,
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          // ô pass
                          MyTextField(
                            controller: confirmPasswordController,
                            hintText: "Confirm password",
                            obscureText: true,
                          ),

                          const SizedBox(
                            height: 50,
                          ),

                          // sign in button
                          MyButton(
                              onTap: () => signUp(context),
                              title: 'Sign up',
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
          )),
    );
  }
}
