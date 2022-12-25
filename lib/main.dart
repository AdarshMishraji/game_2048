import 'package:flutter/material.dart';
import 'package:game_2048/theme/app_theme.dart';
import 'package:game_2048/widgets/home.dart';

void main() {
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const Home(),
    );
  }
}
