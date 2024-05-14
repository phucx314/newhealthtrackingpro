import 'package:app3/colors/color_set.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Tip1Page());
}

class Tip1Page extends StatelessWidget {
  const Tip1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      home: WaterBenefitsPage(),
    );
  }
}

class WaterBenefitsPage extends StatelessWidget {
  const WaterBenefitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlueAccent, Colors.blue],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: htaPrimaryColors.shade50,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Water Wonders:\nThe Benefits of Hydration',
                      style: TextStyle(
                        color: htaPrimaryColors.shade400,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Text(
                    'Staying hydrated is crucial for overall health. Did you know that drinking enough water can improve digestion, regulate body temperature, and even help maintain clear skin?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/bottle.png', // Replace with your image asset path
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
