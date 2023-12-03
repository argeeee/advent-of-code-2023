import 'package:aoc_03/bound.dart';

class Element {
  final int x;
  final int y;
  final int width;
  final int height;

  Element(this.x, this.y, this.width, this.height);

  bool isAdjacentTo(Element o) {
    final thisBoundWithCorner = Bound(x - 1, y - 1, x + width, y + height);
    final otherBound = Bound(o.x, o.y, o.x + o.width - 1, o.y + o.height - 1);

    return thisBoundWithCorner.intersects(otherBound);
  }
}
