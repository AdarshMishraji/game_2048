import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

bool isGameWon(List<List<int>> grid) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (grid[i][j] == 2048) {
        return true;
      }
    }
  }
  return false;
}

bool isGameOver(List<List<int>> grid) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (grid[i][j] == 0) {
        return false;
      }
      if (i != 3 && grid[i][j] == grid[i + 1][j]) {
        return false;
      }
      if (j != 3 && grid[i][j] == grid[i][j + 1]) {
        return false;
      }
    }
  }
  return true;
}

List<List<int>> blankGrid() {
  List<List<int>> rows = [];
  for (int i = 0; i < 4; i++) {
    rows.add([0, 0, 0, 0]);
  }
  return rows;
}

List<List<int>> flipGrid(List<List<int>> grid) {
  for (int i = 0; i < 4; i++) {
    List<int> row = grid[i];
    grid[i] = row.reversed.toList();
  }
  return grid;
}

List<List<int>> transposeGrid(List<List<int>> grid) {
  List<List<int>> newGrid = blankGrid();
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      newGrid[i][j] = grid[j][i];
    }
  }
  return newGrid;
}

bool compare(List<List<int>> a, List<List<int>> b) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (a[i][j] != b[i][j]) {
        return false;
      }
    }
  }
  return true;
}

List<List<int>> copyGrid(List<List<int>> grid) {
  List<List<int>> extraGrid = blankGrid();
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      extraGrid[i][j] = grid[i][j];
    }
  }
  return extraGrid;
}

List<List<int>> addNumber(List<List<int>> grid, List<List<int>> gridNew) {
  List<Point<int>> options = [];
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (grid[i][j] == 0) {
        options.add(Point(i, j));
      }
    }
  }
  if (options.isNotEmpty) {
    int spotRandomIndex = Random().nextInt(options.length);
    Point<int> spot = options[spotRandomIndex];
    int r = Random().nextInt(100);
    grid[spot.x][spot.y] = r > 50 ? 4 : 2;
    gridNew[spot.x][spot.y] = 1;
  }

  return grid;
}

List operate(List<int> row, int score, SharedPreferences? sharedPref) {
  row = slide(row);
  List result = combine(row, score, sharedPref);
  int sc = result[0];
  row = result[1];
  row = slide(row);

  print('from func ${sc}');
  return [sc, row];
}

List<int> filter(List<int> row) {
  List<int> temp = [];
  for (int i = 0; i < row.length; i++) {
    if (row[i] != 0) {
      temp.add(row[i]);
    }
  }
  return temp;
}

List<int> slide(List<int> row) {
  List<int> arr = filter(row);
  int missing = 4 - arr.length;
  List<int> zeroes = zeroArray(missing);
  arr = zeroes + arr;
  return arr;
}

List<int> zeroArray(int length) {
  List<int> zeroes = [];
  for (int i = 0; i < length; i++) {
    zeroes.add(0);
  }
  return zeroes;
}

List combine(List<int> row, int score, SharedPreferences? sharedPref) {
  for (int i = 3; i >= 1; i--) {
    int a = row[i];
    int b = row[i - 1];
    if (a == b) {
      row[i] = a + b;
      score += row[i];
      int? sc = sharedPref?.getInt('high_score');
      if (sc == null) {
        sharedPref?.setInt('high_score', score);
      } else {
        if (score > sc) {
          sharedPref?.setInt('high_score', score);
        }
      }
      row[i - 1] = 0;
    }
  }
  return [score, row];
}
