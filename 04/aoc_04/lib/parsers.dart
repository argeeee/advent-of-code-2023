import 'package:aoc_04/utils.dart';

import 'entities.dart';

void parseLines(String text, LineParser lineParser) {
  final lines = text.split('\n');

  for (var i = 0; i < lines.length; i++) {
    lineParser(lines[i], i, lines.length);
  }
}

Card parseLine(String line) {
  final allNumbers = line.split(': ')[1];
  final [winningNumbersString, numbersYouHaveString] = allNumbers.split(' | ');

  final winningNumbers = getNumbers(winningNumbersString);
  final numbersYouHave = getNumbers(numbersYouHaveString);

  return Card(winningNumbers, numbersYouHave);
}

Set<int> getNumbers(String numbersString) {
  return numbersString
      .split(' ')
      .where(
        (e) => e != '',
      )
      .map(
        (e) => int.parse(e),
      )
      .toSet();
}
