defmodule Aoc2020test.Day2 do
  require Logger
  use ExUnit.Case
  import Helpers, only: [read_file_to_list: 1]
  doctest Aoc2020.Day2

  describe "part 1" do
    test "works for the provided sample" do
      sample_input = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]

      assert Aoc2020.Day2.run(sample_input) == 2
    end

    test "works for the provided list" do
      input = read_file_to_list("./test/day2/input.txt")

      assert Aoc2020.Day2.run(input) == 467
    end
  end

  describe "part 2" do
    test "works for the sample input" do
      sample_input = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]

      assert Aoc2020.Day2.run_part_2(sample_input) == 1
    end

    test "works for the provided list" do
      input = read_file_to_list("./test/day2/input.txt")

      assert Aoc2020.Day2.run_part_2(input) == 441
    end
  end
end
