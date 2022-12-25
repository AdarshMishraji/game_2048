import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 75,
          ),
        ],
      ),
      height: double.infinity,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '2048',
              style: TextStyle(
                fontSize: 50,
                color: Theme.of(context).backgroundColor,
                shadows: [
                  Shadow(
                    color: Theme.of(context).backgroundColor,
                    blurRadius: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(
        double.infinity,
        (const AppBarTheme().toolbarHeight ?? kToolbarHeight) + 25,
      );
}
