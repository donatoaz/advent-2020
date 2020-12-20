defmodule Aoc2020test.Day1 do
  require Logger
  use ExUnit.Case
  import Helpers, only: [read_file_to_list_of_int: 1]
  doctest Aoc2020.Day1

  alias Aoc2020.Day1.{Part1,Part2}

  describe "part 1" do
      test "works for sample list" do
        sample_list = [1721, 979, 366, 299, 675, 1456]

        assert Part1.run(sample_list) == 514_579
      end

      test "works for the provided list" do
        list = read_file_to_list_of_int("./test/day1/input.txt")

        result = Part1.run(list)

        assert result == 1_020_036
      end
  end

  describe "part 2" do
    test "works for sample list" do
      sample_list = [1721, 979, 366, 299, 675, 1456]

      assert Part2.run(sample_list) == 241_861_950
    end

    test "works for the provided list" do
      list = read_file_to_list_of_int("./test/day1/input.txt")

      result = Part2.run(list)

      assert result == 286_977_330
    end
  end

end
