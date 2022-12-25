import 'package:flutter/material.dart';

import 'package:game_2048/widgets/custom_app_bar.dart';
import 'package:game_2048/widgets/grid_2048.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 50,
          horizontal: width * 0.075,
        ),
        child: SizedBox(
          width: width * 0.85,
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Grid2048(width: width * 0.85),
            ],
          ),
        ),
      ),
    );
  }
}
