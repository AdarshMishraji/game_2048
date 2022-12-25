import 'package:flutter/material.dart';

class AppTheme {
  static const gradientColors = [
    Color.fromRGBO(0, 100, 255, 2),
    Color.fromRGBO(0, 125, 255, 1),
    Color.fromRGBO(0, 150, 255, 1),
    Color.fromRGBO(0, 100, 255, 1)
  ];

  static const typography = TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: Colors.blue,
    ),
    titleMedium: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.blue,
    ),
    titleSmall: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.blue,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.blue,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.blue,
    ),
    bodySmall: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.blue,
    ),
    displayLarge: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.blue,
    ),
    displayMedium: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.blue,
    ),
    displaySmall: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.blue,
    ),
    labelLarge: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.blue,
    ),
    labelMedium: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.blue,
    ),
    labelSmall: TextStyle(
      fontFamily: 'ShareHappinessAround',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.blue,
    ),
  );

  static const pageTransitionTheme = PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  });

  static final cardTheme = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );

  static final lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'ShareHappinessAround',
      primarySwatch: Colors.blue,
      textTheme: typography,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: typography.titleLarge!.copyWith(color: Colors.blue),
        iconTheme: const IconThemeData(color: Colors.blue),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      cardTheme: cardTheme,
      pageTransitionsTheme: pageTransitionTheme);

  static final darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'ShareHappinessAround',
    primarySwatch: Colors.blue,
    textTheme: typography,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: typography.titleLarge!.copyWith(color: Colors.blue),
      iconTheme: const IconThemeData(color: Colors.blue),
      elevation: 0,
    ),
    backgroundColor: Colors.black,
    cardTheme: cardTheme,
    pageTransitionsTheme: pageTransitionTheme,
  );
}

class GameColors {
  static int gridBackground = Colors.blue.value;
  static int gridColorTwoFour = 0xFFeee4da;
  static int fontColorTwoFour = 0xFF766c62;
  static int emptyGridBackground = Colors.white38.value;
  static int gridColorEightSixtyFourTwoFiftySix = 0xFFf5b27e;
  static int gridColorOneTwentyEightFiveOneTwo = 0xFFf77b5f;
  static int gridColorSixteenThirtyTwoOneZeroTwoFour = 0xFFecc402;
  static int gridColorWin = 0xFF60d992;
  static int transparentWhite = 0x80FFFFFF;
}
