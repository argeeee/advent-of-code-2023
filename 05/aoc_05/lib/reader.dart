import 'dart:io';

typedef Reader = String Function();

enum ReaderType {
  example,
  real,
}

Reader getReader(ReaderType type) {
  return switch (type) {
    ReaderType.example => () => File("assets/example.txt").readAsStringSync(),
    ReaderType.real => () => File("assets/5.txt").readAsStringSync(),
  };
}
