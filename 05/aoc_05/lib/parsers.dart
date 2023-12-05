import 'package:aoc_05/entities.dart';

enum ParsingState {
  none,
  // seeds, don't needed
  mappers,
}

Garden parseText(String text) {
  final lines = text.split('\n');

  var seeds = <int>[];
  var mappers = <Mapper>[];
  var mappingValuesList = <MappingValues>[];
  var parsingState = ParsingState.none;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];

    if (line.isEmpty || (i == lines.length - 1)) {
      if (parsingState == ParsingState.none) {
        continue;
      }

      final mapper = GenericMapper(
        mappingValuesList,
      );

      mappers.add(mapper);

      // cleaning..
      mappingValuesList = [];
      continue;
    }

    // processing mapping values
    if (int.tryParse(line[0]) != null) {
      final [destinationRangeStart, sourceRangeStart, rangeLength] = line
          .split(' ')
          .map(
            (e) => int.parse(e),
          )
          .toList();

      mappingValuesList.add(MappingValues(
        destinationRangeStart,
        sourceRangeStart,
        rangeLength,
      ));
    }

    if (line.contains('seeds')) {
      seeds = line.split(': ')[1].split(' ').map((e) => int.parse(e)).toList();
    } else if (line.contains('seed-to-soil')) {
      parsingState = ParsingState.mappers;
    }
  }

  return Garden(seeds, MappingEngine(mappers));
}
