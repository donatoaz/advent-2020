defmodule Aoc2020test.Day11 do
  require Logger
  use ExUnit.Case
  import Helpers, only: [read_file_to_list: 1]
  doctest Aoc2020.Day11

  describe "Part 1" do
    test "it works for sample input" do
      input = read_file_to_list("./test/day11/sample_input.txt")

      assert Aoc2020.Day11.Part1.run(input) == 37
    end

    test "it works for provided input for rodrah" do
      input = read_file_to_list("./test/day11/input-rodrah.txt")

      assert Aoc2020.Day11.Part1.run(input) == 2386
    end

    @tag :skip
    test "it works for provided input for adamu" do
      input = read_file_to_list("./test/day11/input-adamu.txt")

      assert Aoc2020.Day11.Part1.run(input) == 2238
    end

    @tag :skip
    test "it works for provided my input" do
      input = read_file_to_list("./test/day11/input.txt")

      assert Aoc2020.Day11.Part1.run(input) == 2164
    end
  end
end
