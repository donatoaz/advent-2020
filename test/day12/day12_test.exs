defmodule Aoc2020test.Day12 do
  require Logger
  use ExUnit.Case
  import Helpers, only: [read_file_to_list: 1]
  doctest Aoc2020.Day12

  describe "Part 1" do
    test "it works for sample input" do
      input = read_file_to_list("./test/day12/sample_input.txt")

      assert Aoc2020.Day12.Part1.run(input) == 25
    end

    test "it works for my input file" do
      input = read_file_to_list("./test/day12/input.txt")

      assert Aoc2020.Day12.Part1.run(input) == 1148
    end
  end

  describe "Part 2" do
    test "it works for the sample input" do
      input = read_file_to_list("./test/day12/sample_input.txt")

      assert Aoc2020.Day12.Part2.run(input) == 286
    end

    test "it works for my input file" do
      input = read_file_to_list("./test/day12/input.txt")

      assert Aoc2020.Day12.Part2.run(input) == 52203
    end
  end
end
