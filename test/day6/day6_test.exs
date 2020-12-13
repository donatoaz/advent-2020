defmodule Aoc2020test.Day6 do
  require Logger
  use ExUnit.Case
  doctest Aoc2020.Day6

  defp read_file_to_list(path) do
    {:ok, content} = File.read(path)

    content
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn e -> String.split(e, ~r/\s+/) end)
  end

  test "it works for provided sample" do
    sample_input = read_file_to_list("./test/day6/sample_input.txt")

    assert Aoc2020.Day6.run(sample_input) == 11
  end

  test "it works for the provided file" do
    input = read_file_to_list("./test/day6/input.txt")

    assert Aoc2020.Day6.run(input) == 6506
  end

  test "it works for the provided sample for part 2" do
    sample_input = read_file_to_list("./test/day6/sample_input.txt")

    assert Aoc2020.Day6.run_part_2(sample_input) == 6
  end

  test "it works for the provided file for part 2" do
    input = read_file_to_list("./test/day6/input.txt")

    assert Aoc2020.Day6.run_part_2(input) == 3243
  end
end
