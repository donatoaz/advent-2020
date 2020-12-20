defmodule Aoc2020test.Day8 do
  require Logger
  use ExUnit.Case
  import Helpers, only: [read_file_to_list: 1]
  doctest Aoc2020.Day8

  describe "part 1" do
    test "it works for sample input" do
      input = read_file_to_list("./test/day8/sample_input.txt")

      assert Aoc2020.Day8.Part1.run(input) == {:infinite_loop, 5}
    end

    test "it works for provided file" do
      input = read_file_to_list("./test/day8/input.txt")

      assert Aoc2020.Day8.Part1.run(input) == {:infinite_loop, 1915}
    end
  end

  describe "part 2" do
    test "it works for sample input" do
      input = read_file_to_list("./test/day8/sample_input.txt")

      assert Aoc2020.Day8.Part2.run(input) == {:ok, 8}
    end

    test "it works for provided file" do
      input = read_file_to_list("./test/day8/input.txt")

      assert Aoc2020.Day8.Part2.run(input) == {:ok, 944}
    end
  end
end
