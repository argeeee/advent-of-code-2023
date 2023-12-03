import 'package:aoc_03/element.dart';
import 'package:aoc_03/number_element.dart';
import 'package:aoc_03/row.dart';
import 'package:aoc_03/symbol_element.dart';
import 'package:aoc_03/utils.dart';

List<Row> parseText(String text) {
  final lines = text.split('\n');
  var rows = <Row>[];

  for (var y = 0; y < lines.length; y++) {
    final line = lines[y];
    final chars = line.split('');

    List<Element> elements = [];

    for (int x = 0; x < chars.length; x++) {
      final ch = chars[x];

      if (ch == '.') {
        continue;
      }

      if (isDigit(ch)) {
        final [number, length] = readNumber(chars, x);
        elements.add(NumberElement(x, y, length, 1, number));
        x += length - 1; // -1 because there is an x++ in the loop
      } else {
        elements.add(SymbolElement(x, y, 1, 1, chars[x]));
      }
    }

    rows.add(Row(elements));
  }

  return rows;
}

List<int> readNumber(List<String> chars, int i) {
  var length = 0;
  var number = 0;

  while (i < chars.length && isDigit(chars[i])) {
    number = number * 10 + int.parse(chars[i]);
    i++;
    length++;
  }

  return [number, length];
}
