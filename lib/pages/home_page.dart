import "package:flutter/material.dart";

import "../services/auth_service.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: const Image(
        image: AssetImage('assets/images/test.png'),
      ),
    );
  }
}
