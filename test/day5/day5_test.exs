defmodule Aoc2020test.Day5 do
  require Logger
  use ExUnit.Case
  doctest Aoc2020.Day5

  defp read_file_to_list(path) do
    {:ok, content} = File.read(path)

    content
    |> String.split("\n", trim: true)
  end

  test "it works for provided sample" do
    sample_input = ["FBFBBFFRLR"]

    assert Aoc2020.Day5.run(sample_input) == 357
  end

  test "it works for provided input file" do
    input = read_file_to_list("./test/day5/input.txt")

    assert Aoc2020.Day5.run(input) == 947
  end

  test "it works for provided input file for part 2" do
    input = read_file_to_list("./test/day5/input.txt")

    assert Aoc2020.Day5.run_part_2(input) == 636
  end
end
