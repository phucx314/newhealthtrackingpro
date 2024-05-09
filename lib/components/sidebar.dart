import 'package:app3/auth/plan_or_recipes.dart';
import 'package:app3/models/plan.dart';
import 'package:app3/pages/list_chat.dart';
import 'package:app3/pages/planpage.dart';
import 'package:app3/pages/recipes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../colors/color_set.dart';
import '../components/sidebar_item.dart';
import '../pages/bmi_calculator.dart';
import '../pages/chat_page.dart';
import '../pages/dashboard.dart';
import '../pages/my_account.dart';

import '../pages/dashboard.dart';
import '../services/auth_service.dart';

class Sidebar extends StatelessWidget {
  Sidebar({super.key});
  final auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // logo app
            const Align(
              alignment: Alignment.centerLeft,
              child: Image(
                image: AssetImage(
                  'assets/images/app_title_logo.png',
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),

            // menu title
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Menu',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: htaPrimaryColors.shade500),
                  )),
            ),
            const SizedBox(
              height: 25,
            ),

            // trên
            Expanded(
              child: Column(
                children: [
                  SidebarItem(
                    name: 'Dashboard',
                    icon: Icons.dashboard,
                    onTap: () => onItemTap(context, index: 0),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SidebarItem(
                    name: 'Plans',
                    icon: Icons.list,
                    onTap: () => onItemTap(context, index: 1),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SidebarItem(
                    name: 'Recipes',
                    icon: Icons.bookmark,
                    onTap: () => onItemTap(context, index: 2),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SidebarItem(
                    name: 'Dr.Zone (underdev)',
                    icon: Icons.local_hospital,
                    onTap: () => onItemTap(context, index: 3),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SidebarItem(
                    name: 'BMI',
                    icon: Icons.calculate,
                    onTap: () => onItemTap(context, index: 4),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SidebarItem(
                    name: 'Profile',
                    icon: Icons.person_rounded,
                    onTap: () => onItemTap(context, index: 5),
                  ),
                ],
              ),
            ),

            // dưới
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  SidebarItem(
                    name: 'Log out',
                    icon: Icons.logout,
                    onTap: () => {auth.signOut()},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SidebarItem(
                    name: 'Settings',
                    icon: Icons.settings,
                    onTap: () => onItemTap(context, index: 8),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SidebarItem(
                    name: 'Development team',
                    icon: Icons.info,
                    onTap: () => onItemTap(context, index: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onItemTap(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PlanOrRecipe()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PlanOrRecipe()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ListChat()));
        break;

      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const BMI()));
        break;
      case 5:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyAccount()));
        break;

      // case 7: Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard())); break;
      // case 8: Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard())); break;
      // case 9: Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard())); break;
      default:
        Navigator.pop(context);
        break;
    }
  }
}
