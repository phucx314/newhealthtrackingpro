import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../colors/color_set.dart';
import '../styles/box_shadow.dart';
import '../components/sidebar.dart'; // Import your SideBar widget

class MyAppBar extends StatefulWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onNotificationPressed;

  const MyAppBar({
    super.key,
    this.onMenuPressed,
    this.onProfilePressed,
    this.onNotificationPressed,
  });

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  String _username = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        setState(() {
          _username = userDoc['fullname'] ?? 'No Name';
        });
      } else {
        setState(() {
          _username = 'Guest';
        });
      }
    } catch (e) {
      setState(() {
        _username = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Menu button
        IconButton(
          onPressed: widget.onMenuPressed ??
              () {
                // Open sidebar
                Scaffold.of(context).openDrawer();
              },
          icon: Image.asset(
            'assets/icons/btn_menu.png',
            width: 30,
            height: 30,
          ),
        ),
        const SizedBox(width: 15),

        // Profile pic with username
        Expanded(
          child: Container(
            height: 60,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: htaPrimaryColors.shade50,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [shadow],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Hi, $_username',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: htaPrimaryColors.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),

        // Notification button
        IconButton(
          onPressed: widget.onNotificationPressed,
          icon: Image.asset(
            'assets/icons/btn_noti.png',
            width: 35,
            height: 35,
          ),
        ),
      ],
    );
  }
}
