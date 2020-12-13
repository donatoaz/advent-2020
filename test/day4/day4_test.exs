defmodule Aoc2020test.Day4 do
  require Logger
  use ExUnit.Case
  doctest Aoc2020.Day4

  defp read_file_to_list(path) do
    {:ok, content} = File.read(path)

    content
    |> String.split("\n\n", trim: true)
  end

  test "it works for the provided sample" do
    sample_input = read_file_to_list("./test/day4/sample_input.txt")
    result = Aoc2020.Day4.run(sample_input)

    assert result == 2
  end

  test "it works for the provided input file" do
    sample_input = read_file_to_list("./test/day4/input.txt")
    result = Aoc2020.Day4.run(sample_input)

    assert result == 233
  end

  test "it works for the provided sample for part 2" do
    sample_input = read_file_to_list("./test/day4/sample_input2.txt")
    result = Aoc2020.Day4.run_part_2(sample_input)

    assert result == 4
  end

  test "it works for the provided input file for part 2" do
    sample_input = read_file_to_list("./test/day4/input.txt")
    result = Aoc2020.Day4.run_part_2(sample_input)

    assert result == 111
  end
end
