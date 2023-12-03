import 'dart:io';

import 'package:aoc_03/input.dart';
import 'package:aoc_03/row.dart';
import 'package:aoc_03/symbol_element.dart';

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

    final numberElements = currRow.numbers;
    final symbolsToCheck = getOnlySymbols(rowsToCheck);

    for (var number in numberElements) {
      for (var symbol in symbolsToCheck) {
        if (number.isAdjacentTo(symbol)) {
          result += number.value;
        }
      }
    }

    // Remove fist row if we are not in the first row
    if (i != 0) {
      rowsToCheck.removeAt(0);
    }
  }

  return result;
}

List<SymbolElement> getOnlySymbols(List<Row> rows) {
  return rows.map((r) => r.symbols).fold(
    <SymbolElement>[],
    (previousValue, symbols) => [...previousValue, ...symbols],
  );
}
