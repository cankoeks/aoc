# Simple Makefile for Advent of Code C++ solutions
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2
TARGET = solution
SOURCES = main.cpp

# Default target
$(TARGET): $(SOURCES)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SOURCES)

# Run the solution
run: $(TARGET)
	./$(TARGET)

# Clean compiled files
clean:
	rm -f $(TARGET)

# Debug build
debug: CXXFLAGS += -g -DDEBUG
debug: $(TARGET)

.PHONY: run clean debug
