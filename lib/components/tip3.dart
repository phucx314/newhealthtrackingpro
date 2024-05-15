import 'package:flutter/material.dart';

import '../pages/dashboard.dart';

void main() {
  runApp(const Tip3Page());
}

class Tip3Page extends StatelessWidget {
  const Tip3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NaturePharmacyPage(),
    );
  }
}

class NaturePharmacyPage extends StatelessWidget {
  const NaturePharmacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF004D40), Color(0xFF80CBC4)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Leaf top image
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/leaf_top.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Leaf bottom image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/leaf_bottom.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Back button
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  Dashboard()),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 200),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade700,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 20, top: 8, bottom: 8),
                        child: Text(
                          'Nature\'s    \nPharmacy',
                          style: TextStyle(
                            color: Colors.green.shade100,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Text(
                        'Herbs and spices are not only flavorful additions to meals but also packed with health benefits. For example, turmeric has anti-inflammatory properties, while cinnamon may help regulate blood sugar levels.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
