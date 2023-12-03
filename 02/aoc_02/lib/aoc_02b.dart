import 'dart:io';

String readFile() {
  return File("assets/2.txt").readAsStringSync();
}

int calc() {
  var result = 0;

  final lines = readFile().split('\n');

  for (var line in lines) {
    final [_, setsSting] = line.split(': ');
    final sets = setsSting.split('; ');

    var maxRed = 0;
    var maxGreen = 0;
    var maxBlue = 0;

    for (var set in sets) {
      var currRed = 0;
      var currGreen = 0;
      var currBlue = 0;

      final relevations = set.split(', ');

      for (var r in relevations) {
        final [n, cubesColor] = r.split(' ');

        switch (cubesColor) {
          case 'red':
            currRed = int.parse(n);
            if (currRed > maxRed) {
              maxRed = currRed;
            }
            break;
          case 'green':
            currGreen = int.parse(n);
            if (currGreen > maxGreen) {
              maxGreen = currGreen;
            }
            break;
          case 'blue':
            currBlue = int.parse(n);
            if (currBlue > maxBlue) {
              maxBlue = currBlue;
            }
            break;
          default:
            break;
        }
      }
    }

    result += (maxRed * maxGreen * maxBlue);
  }

  return result;
}
