defmodule Aoc2020test.Day14 do
  use ExUnit.Case
  import Helpers, only: [read_file_to_list: 1]
  doctest Aoc2020.Day14.Part2

  describe "Part1" do
    test "it works for provided sample" do
      input = read_file_to_list("./test/day14/sample_input.txt")

      assert Aoc2020.Day14.Part1.run(input) == 165
    end

    test "it works for provided input" do
      input = read_file_to_list("./test/day14/input.txt")

      assert Aoc2020.Day14.Part1.run(input) == 10_885_823_581_193
    end
  end

  describe "Part 2" do
    test "it works for provided sample" do
      input = read_file_to_list("./test/day14/sample_input_part2.txt")

      assert Aoc2020.Day14.Part2.run(input) == 208
    end

    test "it works for provided input" do
      input = read_file_to_list("./test/day14/input.txt")

      assert Aoc2020.Day14.Part2.run(input) == 3_816_594_901_962
    end
  end
end
