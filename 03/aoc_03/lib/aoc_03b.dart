import 'dart:io';

import 'package:aoc_03/input.dart';
import 'package:aoc_03/number_element.dart';
import 'package:aoc_03/row.dart';

String readFile() {
  return File("assets/3.txt").readAsStringSync();
}

int calc() {
  var result = 0;

  String text = readFile();
  List<Row> rows = parseText(text);

  List<Row> rowsToCheck = [rows[0]];

  for (int i = 0; i < rows.length; i++) {
    // Add next row if can
    if (i < rows.length - 1) {
      rowsToCheck.add(rows[i + 1]);
    }

    final currRow = rows[i];

    final symbolElements = currRow.symbols;
    final numbersToCheck = getOnlyNumbers(rowsToCheck);

    for (var symbol in symbolElements) {
      var adjacentNumbers = <NumberElement>[];
      for (var number in numbersToCheck) {
        if (number.isAdjacentTo(symbol)) {
          adjacentNumbers.add(number);
        }
      }
      if (adjacentNumbers.length == 2) {
        result += adjacentNumbers[0].value * adjacentNumbers[1].value;
      }
    }

    // Remove fist row if we are not in the first row
    if (i != 0) {
      rowsToCheck.removeAt(0);
    }
  }

  return result;
}

List<NumberElement> getOnlyNumbers(List<Row> rows) {
  return rows.map((r) => r.numbers).fold(
    <NumberElement>[],
    (previousValue, numbers) => [...previousValue, ...numbers],
  );
}
