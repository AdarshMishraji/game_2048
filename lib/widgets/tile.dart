import 'package:flutter/material.dart';
import 'package:game_2048/theme/app_theme.dart';

class Tile extends StatelessWidget {
  final int number;
  final double width, height;

  late final String numberString;

  Tile({
    super.key,
    required this.number,
    required this.width,
    required this.height,
  }) {
    numberString = number == 0 ? '' : number.toString();
  }

  double getTextSize() {
    switch (numberString.length) {
      case 1:
      case 2:
        return 40.0;
      case 3:
        return 30.0;
      case 4:
        return 20.0;
      default:
        return 0;
    }
  }

  int getGridColor() {
    switch (number) {
      case 0:
        return GameColors.emptyGridBackground;
      case 2:
      case 4:
        return GameColors.gridColorTwoFour;
      case 8:
      case 64:
      case 256:
        return GameColors.gridColorEightSixtyFourTwoFiftySix;
      case 16:
      case 32:
      case 1024:
        return GameColors.gridColorSixteenThirtyTwoOneZeroTwoFour;
      case 128:
      case 512:
        return GameColors.gridColorOneTwentyEightFiveOneTwo;
      default:
        return GameColors.gridColorWin;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(getGridColor()),
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Center(
        child: Text(
          numberString,
          style: TextStyle(
            fontSize: getTextSize(),
            fontWeight: FontWeight.bold,
            color: Color(GameColors.fontColorTwoFour),
          ),
        ),
      ),
    );
  }
}
