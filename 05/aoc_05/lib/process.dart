import 'dart:math';
import 'package:aoc_05/entities.dart';

enum Part {
  first,
  second,
}

typedef ProcessingFunction = int Function(Garden);

ProcessingFunction getProcessingFunction(Part part) {
  return switch (part) {
    Part.first => firstPart,
    Part.second => secondPart,
  };
}

ProcessingFunction firstPart = (garden) {
  return garden.getLocationForSeeds().reduce(min);
};

ProcessingFunction secondPart = (garden) {
  return garden.getMinLocationFromRanges();
};
