defmodule Aoc2020test.Day2 do
  require Logger
  use ExUnit.Case
  doctest Aoc2020.Day2

  defp read_file_to_list(path) do
    {:ok, content} = File.read(path)

    content
    |> String.split("\n", trim: true)
  end

  test "works for the provided sample" do
    sample_input = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]

    assert Aoc2020.Day2.run(sample_input) == 2
  end

  test "works for the provided list" do
    input = read_file_to_list("./test/day2/input.txt")

    assert Aoc2020.Day2.run(input) == 467
  end

  test "works for the sample input of part 2" do
    sample_input = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]

    assert Aoc2020.Day2.run_part_2(sample_input) == 1
  end

  test "works for the provided list on part 2" do
    input = read_file_to_list("./test/day2/input.txt")

    assert Aoc2020.Day2.run_part_2(input) == 441
  end
end
