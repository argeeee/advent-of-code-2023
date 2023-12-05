import 'package:aoc_05/parsers.dart';
import 'package:aoc_05/process.dart';
import 'package:aoc_05/reader.dart';

int exec(Reader reader, ProcessingFunction processingFn) {
  final text = reader();
  final garden = parseText(text);
  return processingFn(garden);
}
