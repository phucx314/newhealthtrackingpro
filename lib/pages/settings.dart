import 'package:app3/components/sideBar.dart';
import 'package:flutter/material.dart';

import '../colors/color_set.dart';
import '../components/appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: MyAppBar(username: "Rosser"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: htaPrimaryColors.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Theme',
                      style: TextStyle(
                        color: htaPrimaryColors.shade500,
                      ),
                    )
                    // Add your child widgets here
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
