import 'package:aoc_03/element.dart';
import 'package:aoc_03/number_element.dart';
import 'package:aoc_03/symbol_element.dart';

class Row {
  final List<Element> elements;

  Row(this.elements);

  List<NumberElement> get numbers =>
      elements.whereType<NumberElement>().toList();

  List<SymbolElement> get symbols =>
      elements.whereType<SymbolElement>().toList();
}
