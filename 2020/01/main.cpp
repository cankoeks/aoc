#include <iostream>
#include <fstream>
#include <string>
#include <vector>

void part1(const std::vector<long long>& lines);
void part2(const std::vector<long long>& lines);

int main() {
  std::ifstream file("input.txt");
  if (!file.is_open()) {
    std::cerr << "Error: Could not open input.txt" << std::endl;
    return 1;
  }

  std::vector<long long> lines;
  std::string line;
  
  while (std::getline(file, line)) {
    lines.push_back(std::stoll(line));
  }
  file.close();

  part1(lines);
  part2(lines);

  return 0;
}
  
void part1(const std::vector<long long>& lines) {
  for (const auto& line : lines) {
    for (const auto& line2 : lines) {
      if (line == line2) {
        continue;
      }
      if (line + line2 == 2020) {
        long long result = line * line2;
        std::cout << result << std::endl;
        return;
      }
    }
  }
}

void part2(const std::vector<long long>& lines) {
  for (const auto& line : lines) {
    for (const auto& line2 : lines) {
      for (const auto& line3 : lines) {
        if (line == line2 || line == line3 || line2 == line3) {
          continue;
        }
        if (line + line2 + line3 == 2020) {
          long long result = line * line2 * line3;
          std::cout << result << std::endl;
          return;
        }
      }
    }
  }
}
