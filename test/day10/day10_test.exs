defmodule Aoc2020test.Day10 do
  require Logger
  use ExUnit.Case
  import Helpers, only: [read_file_to_list_of_int: 1]
  doctest Aoc2020.Day10.Part2

  # describe "Part 1" do
  #   test "it works for provided sample" do
  #     input = read_file_to_list_of_int("./test/day10/sample_input.txt")

  #     assert Aoc2020.Day10.Part1.run(input) == 220
  #   end

  #   test "it works for provided input" do
  #     input = read_file_to_list_of_int("./test/day10/input.txt")

  #     assert Aoc2020.Day10.Part1.run(input) == 2030
  #   end
  # end

  describe "Part 2" do
    test "it works for provided small sample" do
      input = read_file_to_list_of_int("./test/day10/sample_input_small.txt")

      assert Aoc2020.Day10.Part2.run(input) == 8
    end

    test "it works for provided sample" do
      input = read_file_to_list_of_int("./test/day10/sample_input.txt")

      assert Aoc2020.Day10.Part2.run(input) == 19208
    end

    test "it works for provided input" do
      input = read_file_to_list_of_int("./test/day10/input.txt")

      assert Aoc2020.Day10.Part2.run(input) == 42_313_823_813_632
    end
  end
end
