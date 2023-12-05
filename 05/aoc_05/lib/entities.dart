import 'dart:math';

class MappingValues {
  final int destinationRangeStart;
  final int sourceRangeStart;
  final int rangeLength;

  MappingValues(
    this.destinationRangeStart,
    this.sourceRangeStart,
    this.rangeLength,
  );
}

typedef Range = List<int>;

abstract class Mapper {
  int map(int source);
  List<Range> mapRange(Range range);
}

abstract class GenericMapper implements Mapper {
  final List<MappingValues> mappingValuesList;

  GenericMapper(this.mappingValuesList);

  @override
  int map(int source) {
    for (var mv in mappingValuesList) {
      var range = [
        mv.sourceRangeStart,
        mv.sourceRangeStart + mv.rangeLength - 1,
      ];

      if (isInRange(range, source)) {
        return mv.destinationRangeStart + (source - mv.sourceRangeStart);
      }
    }

    return source;
  }

  @override
  List<Range> mapRange(Range range) {
    throw UnimplementedError();
    /*
    List<List<Range>> ranges = [];

    for (var mv in mappingValuesList) {
      var range = [
        mv.sourceRangeStart,
        mv.sourceRangeStart + mv.rangeLength - 1,
      ];

      if (isInRange(range, source)) {
        return mv.destinationRangeStart + (source - mv.sourceRangeStart);
      }
    }
    */
  }

  static bool isInRange(List<int> range, int position) {
    return range[0] <= position && range[1] >= position;
  }
}

class SeedToSoilMapper extends GenericMapper {
  SeedToSoilMapper(super.mappingValues);
}

class SoilToFertilizerMapper extends GenericMapper {
  SoilToFertilizerMapper(super.mappingValues);
}

class FertilizerToWaterMapper extends GenericMapper {
  FertilizerToWaterMapper(super.mappingValues);
}

class WaterToLightMapper extends GenericMapper {
  WaterToLightMapper(super.mappingValues);
}

class LightToTemperature extends GenericMapper {
  LightToTemperature(super.mappingValues);
}

class TemperatureToHumidity extends GenericMapper {
  TemperatureToHumidity(super.mappingValues);
}

class HumidityToLocation extends GenericMapper {
  HumidityToLocation(super.mappingValues);
}

class MappingEngine {
  final List<Mapper> mappers;

  MappingEngine(this.mappers);

  int map(int seed) {
    var result = seed;

    for (var mapper in mappers) {
      result = mapper.map(result);
    }

    return result;
  }

  // returns locations
  List<int> mapRange(Range range) {
    final [start, end] = range;
    List<int> locations = [];

    for (int seed = start; seed <= end; seed++) {
      locations.add(map(seed));
    }

    return locations;
  }
}

class Garden {
  final List<int> seeds;
  final MappingEngine mappingEngine;

  Garden(this.seeds, this.mappingEngine);

  List<int> getLocationForGivenSeeds(List<int> givenSeeds) {
    return givenSeeds.map((seed) => mappingEngine.map(seed)).toList();
  }

  List<int> getLocationForSeeds() {
    return getLocationForGivenSeeds(seeds);
  }

  int getMinLocationFromRanges() {
    var currCount = 0;

    const int maxInteger = 0x7FFFFFFFFFFFFFFF;
    var currMin = maxInteger;

    for (var i = 0; i < seeds.length; i += 2) {
      final start = seeds[i];
      final length = seeds[i + 1];

      var seedsFromRanges = listFromRange(start, length);

      currMin = min(
        currMin,
        getLocationForGivenSeeds(seedsFromRanges).reduce(min),
      );

      currCount += seedsFromRanges.length;
      print(currCount);
    }

    return currMin;
  }

  List<int> listFromRange(int start, int length) =>
      List.generate(length, (index) => start + index);
}
