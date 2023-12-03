#include <iostream>
#include <string>

#define N 1000
#define isDigit(x) ((x) >= '0' && (x) <= '9')
#define charToInt(c) ((c) - '0')

int main() {
  using namespace std;

  string line;
  int i = 0;

  long sum = 0, curr;

  for (int i = 0; i < N; i++) {
    getline(cin, line);
    curr = 0;

    for (int j = 0; j < line.size(); j++) {
      if (isDigit(line[j])) {
        curr += charToInt(line[j]) * 10;
        break;
      }
    }

    for (int j = line.size() - 1; j >= 0; j--) {
      if (isDigit(line[j])) {
        curr += charToInt(line[j]);
        break;
      }
    }

    sum += curr;
  }

  return cout << sum << "\n", 0;
}