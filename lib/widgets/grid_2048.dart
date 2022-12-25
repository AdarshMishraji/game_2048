import 'package:flutter/material.dart';
import 'package:game_2048/theme/app_theme.dart';
import 'package:game_2048/utils/constants.dart';
import 'package:game_2048/utils/game_logic.dart';
import 'package:game_2048/widgets/tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Grid2048 extends StatefulWidget {
  final double width;
  const Grid2048({super.key, required this.width});

  @override
  State<Grid2048> createState() => _Grid2048State();
}

class _Grid2048State extends State<Grid2048> {
  List<List<int>> grid = [];
  List<List<int>> gridNew = [];
  SharedPreferences? sharedPreferences;
  int score = 0;
  bool isOver = false;
  bool isWon = false;

  List<Widget> getGrid(double width, double height) {
    List<Widget> grids = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        int num = grid[i][j];
        grids.add(Tile(
          number: num,
          width: width,
          height: height,
        ));
      }
    }
    return grids;
  }

  void handleGesture(GestureDirection direction) {
    bool flipped = false;
    bool played = true;
    bool rotated = false;
    if (direction == GestureDirection.up) {
      grid = transposeGrid(grid);
      grid = flipGrid(grid);
      rotated = true;
      flipped = true;
    } else if (direction == GestureDirection.down) {
      grid = transposeGrid(grid);
      rotated = true;
    } else if (direction == GestureDirection.left) {
    } else if (direction == GestureDirection.right) {
      grid = flipGrid(grid);
      flipped = true;
    } else {
      played = false;
    }

    if (played) {
      List<List<int>> past = copyGrid(grid);
      for (int i = 0; i < 4; i++) {
        List result = operate(grid[i], score, sharedPreferences);
        score = result[0];
        grid[i] = result[1];
      }

      grid = addNumber(grid, gridNew);
      if (flipped) {
        grid = flipGrid(grid);
      }

      if (rotated) {
        grid = transposeGrid(grid);
      }

      bool changed = compare(past, grid);

      if (changed) {
        grid = addNumber(grid, gridNew);
      }

      setState(() {});

      bool gameOver = isGameOver(grid);
      if (gameOver) {
        setState(() {
          isOver = true;
        });
      }

      bool gameWon = isGameWon(grid);
      if (gameWon) {
        setState(() {
          isWon = true;
        });
      }
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    grid = blankGrid();
    gridNew = blankGrid();
    addNumber(grid, gridNew);
    addNumber(grid, gridNew);
    super.initState();
  }

  Future<String> getHighScore() async {
    sharedPreferences = await SharedPreferences.getInstance();
    int? score = sharedPreferences?.getInt('high_score');
    score ??= 0;
    return score.toString();
  }

  @override
  Widget build(BuildContext context) {
    double gridWidth = (widget.width - 80) / 4;
    double gridHeight = gridWidth;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Color(GameColors.gridBackground),
            ),
            height: 82.0,
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 2.0),
                  child: Text(
                    'Score',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    '$score',
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: widget.width,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(GameColors.gridBackground),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  child: GridView.count(
                    primary: false,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    crossAxisCount: 4,
                    padding: const EdgeInsets.all(0.0),
                    children: getGrid(gridWidth, gridHeight),
                  ),
                  onVerticalDragEnd: (details) {
                    if ((details.primaryVelocity ?? 0) < 0) {
                      handleGesture(GestureDirection.up);
                    } else if ((details.primaryVelocity ?? 0) > 0) {
                      handleGesture(GestureDirection.down);
                    }
                  },
                  onHorizontalDragEnd: (details) {
                    if ((details.primaryVelocity ?? 0) > 0) {
                      handleGesture(GestureDirection.left);
                    } else if ((details.primaryVelocity ?? 0) < 0) {
                      handleGesture(GestureDirection.right);
                    }
                  },
                ),
              ),
              if (isOver)
                Container(
                  height: widget.width,
                  color: Color(GameColors.transparentWhite),
                  child: Center(
                    child: Text(
                      'Game over!',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color(GameColors.gridBackground)),
                    ),
                  ),
                )
              else
                const SizedBox(),
              if (isWon)
                Container(
                  height: widget.width,
                  color: Color(GameColors.transparentWhite),
                  child: Center(
                    child: Text(
                      'You Won!',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color(GameColors.gridBackground)),
                    ),
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(GameColors.gridBackground),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    iconSize: 35.0,
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        grid = blankGrid();
                        gridNew = blankGrid();
                        grid = addNumber(grid, gridNew);
                        grid = addNumber(grid, gridNew);
                        score = 0;
                        isOver = false;
                        isWon = false;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(GameColors.gridBackground),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'High Score',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FutureBuilder<String>(
                        future: getHighScore(),
                        builder: (ctx, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return const Text(
                              '0',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
