import 'dart:io';
import 'dart:math';

int MULTIPLICATOR = 2;
Future<void> main(List<String> argv) async {
  if (argv.contains("2")) {
    MULTIPLICATOR = 1000000;
  }
  File file = File("input.txt");
  List<String> lines = await file.readAsLines();
  List<List<bool>> grid = parseFile(lines);
  List<Point<int>> galaxyCoords = getGalaxyCoords(grid);

  print(sumDistances(galaxyCoords));
}

List<List<bool>> parseFile(List<String> input) {
  List<List<bool>> result = [];
  for (String line in input) {
    List<bool> row = [];
    for (int i = 0; i < line.length; i++) {
      row.add(line[i] == '#');
    }
    result.add(row);
  }

  return result;
}

List<int> emptyRows(List<List<bool>> grid) {
  List<int> result = [];
  for (List<bool> row in grid) {
    if (row.every((point) => !point)) {
      result.add(grid.indexOf(row));
    }
  }
  return result;
}

List<int> emptyCols(List<List<bool>> grid) {
  List<int> result = [];
  int numRows = grid.length;
  int numCols = grid[0].length;

  for (int colIndex = 0; colIndex < numCols; colIndex++) {
    bool isColEmpty = true;
    for (int rowIndex = 0; rowIndex < numRows; rowIndex++) {
      if (grid[rowIndex][colIndex]) {
        isColEmpty = false;
        break;
      }
    }
    if (isColEmpty) {
      result.add(colIndex);
    }
  }

  return result;
}

List<Point<int>> getGalaxyCoords(List<List<bool>> grid) {
  List<Point<int>> galaxyCoords = [];
  List<int> emptyC = emptyCols(grid);
  List<int> emptyR = emptyRows(grid);

  int currRow = 0;
  int currCol = 0;

  for (int rowIdx = 0; rowIdx < grid.length; rowIdx++) {
    if (emptyR.contains(rowIdx)) {
      currRow += 1 * MULTIPLICATOR;
      continue;
    }

    for (int colIdx = 0; colIdx < grid[rowIdx].length; colIdx++) {
      if (emptyC.contains(colIdx)) {
        currCol += 1 * MULTIPLICATOR;
        continue;
      }

      if (grid[rowIdx][colIdx]) {
        galaxyCoords.add(Point(currCol, currRow));
      }

      currCol += 1;
    }

    currCol = 0;
    currRow += 1;
  }

  return galaxyCoords;
}

int sumDistances(List<Point<int>> galaxyCoords) {
  int sum = 0;
  for (int i = 0; i < galaxyCoords.length; i++) {
    for (int j = i + 1; j < galaxyCoords.length; j++) {
      sum += manhattanDistance(galaxyCoords[i], galaxyCoords[j]);
    }
  }
  return sum;
}

int manhattanDistance(Point<int> point1, Point<int> point2) {
  return (point1.x - point2.x).abs() + (point1.y - point2.y).abs();
}
