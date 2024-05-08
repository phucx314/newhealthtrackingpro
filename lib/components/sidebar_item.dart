import 'package:flutter/material.dart';
import '../colors/color_set.dart';

class SidebarItem extends StatelessWidget {
  const SidebarItem(
      {super.key, required this.name, required this.icon, this.onTap});

  final String name;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: htaPrimaryColors.shade500,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                name,
                style: TextStyle(
                  color: htaPrimaryColors.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
