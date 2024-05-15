import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../colors/color_set.dart';
import '../styles/box_shadow.dart';
import '../components/sidebar.dart'; // Import your SideBar widget

class MyAppBar extends StatelessWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onNotificationPressed;
  final String username;

  const MyAppBar({
    super.key,
    this.onMenuPressed,
    this.onProfilePressed,
    this.onNotificationPressed,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Menu button
        IconButton(
          onPressed: () {
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
                // Avatar
                // const CircleAvatar(
                //   backgroundImage: AssetImage('assets/images/avatar1.png'),
                //   radius: 16,
                // ),
                // const SizedBox(width: 15),
                // Username
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Hi, $username',
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
          onPressed: () {
            // Handle notification button pressed
          },
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
