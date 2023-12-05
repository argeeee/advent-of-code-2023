import 'package:aoc_05/entities.dart';

enum ParsingState {
  none,
  // seeds, don't needed
  seedsToSoil,
  soilToFertilizer,
  fertilizerToWater,
  waterToLight,
  lightToTemperature,
  temperatureToHumidity,
  humidityToLocation,
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

      final mapper = switch (parsingState) {
        ParsingState.seedsToSoil => SeedToSoilMapper(
            mappingValuesList,
          ),
        ParsingState.soilToFertilizer => SoilToFertilizerMapper(
            mappingValuesList,
          ),
        ParsingState.fertilizerToWater => FertilizerToWaterMapper(
            mappingValuesList,
          ),
        ParsingState.waterToLight => WaterToLightMapper(
            mappingValuesList,
          ),
        ParsingState.lightToTemperature => LightToTemperature(
            mappingValuesList,
          ),
        ParsingState.temperatureToHumidity => TemperatureToHumidity(
            mappingValuesList,
          ),
        ParsingState.humidityToLocation => HumidityToLocation(
            mappingValuesList,
          ),
        ParsingState.none => throw Exception("Unexpexted parsing state"),
      };

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
      parsingState = ParsingState.seedsToSoil;
    } else if (line.contains('soil-to-fertilizer')) {
      parsingState = ParsingState.soilToFertilizer;
    } else if (line.contains('fertilizer-to-water')) {
      parsingState = ParsingState.fertilizerToWater;
    } else if (line.contains('water-to-light')) {
      parsingState = ParsingState.waterToLight;
    } else if (line.contains('light-to-temperature')) {
      parsingState = ParsingState.lightToTemperature;
    } else if (line.contains('temperature-to-humidity')) {
      parsingState = ParsingState.temperatureToHumidity;
    } else if (line.contains('humidity-to-location')) {
      parsingState = ParsingState.humidityToLocation;
    }
  }

  return Garden(seeds, MappingEngine(mappers));
}
