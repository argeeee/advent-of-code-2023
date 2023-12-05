import 'dart:collection';

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

class GenericMapper implements Mapper {
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
    List<Range> rangesToReturn = [];
    var rangesToCheck = Queue<Range>();

    rangesToCheck.add(range);

    for (var mv in mappingValuesList) {
      var rangesToAddForChecking = <Range>[];

      final sourceRange = [
        mv.sourceRangeStart,
        mv.sourceRangeStart + mv.rangeLength - 1,
      ];

      while (rangesToCheck.isNotEmpty) {
        final range = rangesToCheck.removeFirst();
        final [start, end] = range;

        bool isLeftInRange = isInRange(sourceRange, start);
        bool isRightInRange = isInRange(sourceRange, end);

        // Case fully contained
        if (isLeftInRange && isRightInRange) {
          // return only one range
          rangesToReturn.add([
            mv.destinationRangeStart + (start - mv.sourceRangeStart), // start
            mv.destinationRangeStart + (end - mv.sourceRangeStart), // end
          ]);
          // Case contained to left
        } else if (isLeftInRange) {
          // return the left part + ...
          rangesToReturn.add([
            mv.destinationRangeStart + (start - mv.sourceRangeStart), // start
            mv.destinationRangeStart +
                (sourceRange[1] - mv.sourceRangeStart), // end
          ]);

          // ... add the part not contained to list of future checks
          rangesToAddForChecking.add([
            mv.sourceRangeStart + mv.rangeLength, // start
            end,
          ]);
        }
        // Case contained to right
        else if (isRightInRange) {
          // return the right part + ...
          rangesToReturn.add([
            mv.destinationRangeStart, // start
            mv.destinationRangeStart + (end - mv.sourceRangeStart), // end
          ]);

          // ... add the part not contained to list of future checks
          rangesToAddForChecking.add([
            start, // start
            mv.sourceRangeStart - 1,
          ]);
        }
        // Case not contained
        else if (sourceRange[0] >= start && sourceRange[1] <= end) {
          // split in 3
          rangesToReturn.add([
            mv.destinationRangeStart, // start
            mv.destinationRangeStart + mv.rangeLength - 1, // end
          ]);

          rangesToAddForChecking.add([
            start, // start
            sourceRange[0] - 1,
          ]);

          rangesToAddForChecking.add([
            sourceRange[1] + 1, // start
            end,
          ]);
        } else {
          rangesToAddForChecking.add([
            start,
            end,
          ]);
        }
      }

      rangesToCheck.addAll(rangesToAddForChecking);
    }

    return [...rangesToReturn, ...rangesToCheck];
  }

  static bool isInRange(List<int> range, int position) {
    return range[0] <= position && range[1] >= position;
  }
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

  List<Range> mapRanges(List<Range> ranges) {
    for (var mapper in mappers) {
      List<Range> newRanges = [];

      for (var range in ranges) {
        newRanges.addAll(mapper.mapRange(range));
      }

      ranges = newRanges;
    }

    return ranges;
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

  List<int> getStartRangesOfLocationForSeeds() {
    var ranges = <Range>[];

    for (var i = 0; i < seeds.length; i += 2) {
      final start = seeds[i];
      final length = seeds[i + 1];

      ranges.add([start, start + length - 1]);
    }

    return mappingEngine.mapRanges(ranges).map((e) => e[0]).toList();
  }

  List<int> listFromRange(int start, int length) =>
      List.generate(length, (index) => start + index);
}
