class Bound {
  final int boundStartX;
  final int boundStartY;
  final int boundEndX;
  final int boundEndY;

  Bound(this.boundStartX, this.boundStartY, this.boundEndX, this.boundEndY);

  bool intersects(Bound o) {
    final xRange = [boundStartX, boundEndX];
    final yRange = [boundStartY, boundEndY];

    final containedVertically =
        isInRange(xRange, o.boundStartX) || isInRange(xRange, o.boundStartX);

    final containedHorizontally =
        isInRange(yRange, o.boundStartY) || isInRange(yRange, o.boundStartY);

    return containedVertically && containedHorizontally;
  }

  static bool isInRange(List<int> range, int position) {
    // TODO: make sure the range has length 2
    // ...

    return range[0] <= position && range[1] >= position;
  }
}
