import 'package:aoc_03/element.dart';

class NumberElement extends Element {
  final int value;

  NumberElement(super.x, super.y, super.width, super.height, this.value);
}
