import 'package:aoc_04/parsers.dart';
import 'package:aoc_04/reader.dart';

import 'entities.dart';

int exec() {
  final reader = getReader(ReaderType.real);
  final text = reader();

  var result = 0;
  var instancesCount = <int, int>{};

  parseLines(text, (line, index, totalLines) {
    Card card = parseLine(line);

    var matches = 0;

    for (var number in card.numbersYouHave) {
      if (card.winningNumbers.contains(number)) {
        matches++;
      }
    }

    // increment count for current card
    incrementCountForCard(instancesCount, index);
    final numOfInstances = instancesCount[index]!;

    for (var j = 0; j < numOfInstances; j++) {
      // -> for each instance

      for (var i = 0; i < matches; i++) {
        var currIndex = index + i + 1; // lets start from next card

        if (currIndex >= totalLines) {
          break;
        }

        incrementCountForCard(instancesCount, currIndex);
      }
    }
  });

  result = instancesCount.values.fold(
    0,
    (sum, v) => sum + v,
  );

  return result;
}

void incrementCountForCard(Map<int, int> instancesCount, int index) {
  if (!instancesCount.containsKey(index)) {
    instancesCount[index] = 1;
  } else {
    instancesCount[index] = instancesCount[index]! + 1;
  }
}
