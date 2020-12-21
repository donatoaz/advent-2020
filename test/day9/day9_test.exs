defmodule Aoc2020test.Day9 do
  require Logger
  use ExUnit.Case
  import Helpers, only: [read_file_to_list_of_int: 1]
  doctest Aoc2020.Day9

  describe "part 1" do
    test "it works for sample input" do
      input = read_file_to_list_of_int("./test/Day9/sample_input.txt")

      assert Aoc2020.Day9.Part1.run(input, 5) == 127
    end

    test "it works for provided file" do
      input = read_file_to_list_of_int("./test/Day9/input.txt")

      assert Aoc2020.Day9.Part1.run(input, 25) == 69_316_178
    end
  end

  describe "part 2" do
    test "it works for sample input" do
      input = read_file_to_list_of_int("./test/Day9/sample_input.txt")

      assert Aoc2020.Day9.Part2.run(input, 5) == 62
    end

    test "it works for provided file" do
      input = read_file_to_list_of_int("./test/Day9/input.txt")

      assert Aoc2020.Day9.Part2.run(input, 25) == 9_351_526
    end
  end
end
