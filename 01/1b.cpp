// clang++ 1b.cpp -std=c++17 && ./a.out < 1.txt 

#include <iostream>
#include <string>
#include <functional>
#include <unordered_map>

#define N 1000
#define isDigit(x) ((x) >= '0' && (x) <= '9')
#define charToInt(c) ((c) - '0')

int main() {
  using namespace std;

  typedef pair<int, int> pii;
  typedef function<pii(string&)> GetValueAndIndexFn;

  unordered_map<string, long> digits;

  digits["one"]   = 1L;
  digits["two"]   = 2L;
  digits["three"] = 3L;
  digits["four"]  = 4L;
  digits["five"]  = 5L;
  digits["six"]   = 6L;
  digits["seven"] = 7L;
  digits["eight"] = 8L;
  digits["nine"]  = 9L;

  GetValueAndIndexFn getNumberFistDigitIndex = [&](string& line) {
    int index = INT_MAX, curr = 0;

    for (int i = 0; i < line.size(); i++) {
      if (isDigit(line[i])) {
        curr += charToInt(line[i]) * 10;
        index = i;
        break;
      }
    }

    return make_pair(index , curr);
  };

  GetValueAndIndexFn getNumberLastDigitIndex = [&](string& line) {
    int index = -1, curr = 0;

    for (int i = line.size() - 1; i >= 0; i--) {
      if (isDigit(line[i])) {
        curr += charToInt(line[i]);
        index = i;
        break;
      }
    }

    return make_pair(index , curr);
  };

  GetValueAndIndexFn getWordFistDigitIndex = [&](string& line) {
    int index = INT_MAX, curr = 0;

    int i = 0; 
    while ((i + 3) < line.size()) {
      for (auto& e : digits) {
        int substrLen = e.first.size();

        if ((i + substrLen) <= line.size()) {
          string substr = line.substr(i, substrLen);
          if (e.first == substr) {
            curr += e.second * 10;
            index = i;
            break;
          }
        }
        
      }

      if (index != INT_MAX) {
        break;
      }

      i++;
    }

    return make_pair(index , curr);
  };

  GetValueAndIndexFn getWordLastDigitIndex = [&](string& line) {
    int index = -1, curr = 0;
    int i = line.size() - 1;

    while (i >= 0) {
      for (auto& e : digits) {
        int substrLen = e.first.size();

        if ((i + substrLen) <= line.size()) {
          string substr = line.substr(i, substrLen);
          if (e.first == substr) {
            curr += e.second;
            index = i;
            break;
          }
        }
      }

      if (index != -1) {
        break;
      }

      i--;
    }

    return make_pair(index , curr);
  };


  long sum = 0, curr = 0;

  for (int i = 0; i < N; i++) {
    string line; getline(cin, line);
    
    curr = 0;
    
    pii nf = getNumberFistDigitIndex(line),
        nl = getNumberLastDigitIndex(line),
        wf = getWordFistDigitIndex(line),
        wl = getWordLastDigitIndex(line);

    curr += nf.first < wf.first
      ? nf.second
      : wf.second;

    curr += nl.first > wl.first
      ? nl.second
      : wl.second;

    sum += curr;
  }

  return cout << sum << "\n", 0;
}