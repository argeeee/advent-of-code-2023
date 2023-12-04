import 'package:aoc_04/parsers.dart';
import 'package:aoc_04/reader.dart';

import 'entities.dart';

int exec() {
  final reader = getReader(ReaderType.real);
  final text = reader();

  var result = 0;

  parseLines(text, (line, index, _) {
    Card card = parseLine(line);

    var curr = 0;

    for (var number in card.numbersYouHave) {
      if (card.winningNumbers.contains(number)) {
        if (curr == 0) {
          curr = 1;
        } else {
          curr *= 2;
        }
      }
    }

    result += curr;
  });

  return result;
}
