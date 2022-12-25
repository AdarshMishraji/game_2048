import 'package:flutter/material.dart';
import 'package:game_2048/theme/app_theme.dart';

class Icon extends StatelessWidget {
  const Icon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 350,
        width: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
                colors: AppTheme.gradientColors,
                transform: GradientRotation(45))),
        child: const Center(
          child: Text(
            '2048',
            style: TextStyle(
                fontFamily: 'ShareHappinessAround',
                fontSize: 100,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.white,
                    offset: Offset(5, 5),
                    blurRadius: 20,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
