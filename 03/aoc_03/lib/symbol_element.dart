import 'package:aoc_03/element.dart';

class SymbolElement extends Element {
  final String value;

  SymbolElement(super.x, super.y, super.width, super.height, this.value);
}
