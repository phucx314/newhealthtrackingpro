import 'package:flutter/material.dart';

class NotThis extends StatelessWidget {
  const NotThis({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
              child: Expanded(child: Text('Tụi em làm và update ở bên nhánh origin/CDIO2, mong thầy thông cảm và clone hoặc tải file .zip từ nhánh CDIO2 ạ. Tụi em cảm ơn thầy!')),
            ),
          ),
        ),
      ),
    );
  }
}