import 'dart:io';

String readFile() {
  return File("assets/2a.txt").readAsStringSync();
}

const MAX_RED = 12;
const MAX_GREEN = 13;
const MAX_BLUE = 14;

int calc() {
  var result = 0;

  final lines = readFile().split('\n');

  for (var line in lines) {
    final [gameString, setsSting] = line.split(': ');
    final id = gameString.split(' ')[1];
    final sets = setsSting.split('; ');

    var possible = true;

    for (var set in sets) {
      var currRed = 0;
      var currGreen = 0;
      var currBlue = 0;

      final relevations = set.split(', ');

      for (var r in relevations) {
        final [n, cubesColor] = r.split(' ');

        switch (cubesColor) {
          case 'red':
            currRed += int.parse(n);
            break;
          case 'green':
            currGreen += int.parse(n);
            break;
          case 'blue':
            currBlue += int.parse(n);
            break;
          default:
            break;
        }
      }

      if ((currRed > MAX_RED) ||
          (currGreen > MAX_GREEN) ||
          (currBlue > MAX_BLUE)) {
        possible = false;
        break;
      }
    }

    if (possible) {
      result += int.parse(id);
    }
  }

  return result;
}
