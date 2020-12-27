defmodule Aoc2020test.Day13 do
  use ExUnit.Case
  import Helpers, only: [read_file_to_list: 1]

  @tag :skip
  describe "Part1" do
    test "it works for sample input" do
      input = read_file_to_list("./test/day13/sample_input.txt")

      assert Aoc2020.Day13.Part1.run(input) == 295
    end

    test "it works for my input" do
      input = read_file_to_list("./test/day13/input.txt")

      assert Aoc2020.Day13.Part1.run(input) == 1915
    end
  end

  describe "Part 2" do
    test "it works for sample input" do
      input = read_file_to_list("./test/day13/sample_input.txt")

      assert Aoc2020.Day13.Part2.run(input) == 1_068_781
    end

    test "it works for my input" do
      input = read_file_to_list("./test/day13/input.txt")

      assert Aoc2020.Day13.Part2.run(input) == 294_354_277_694_107
    end
  end
end
