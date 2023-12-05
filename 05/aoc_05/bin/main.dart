import 'package:aoc_05/exec.dart';
import 'package:aoc_05/process.dart';
import 'package:aoc_05/reader.dart';

void main(List<String> args) {
  print('Result: ${exec(
    getReader(ReaderType.real),
    getProcessingFunction(Part.second),
  )}');
}
