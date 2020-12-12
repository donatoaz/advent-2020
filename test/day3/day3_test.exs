defmodule Aoc2020test.Day3 do
  require Logger
  use ExUnit.Case
  doctest Aoc2020.Day3

  defp read_file_to_list(path) do
    {:ok, content} = File.read(path)

    content
      |> String.split("\n", trim: true)
  end

  test "works for the provided sample" do
    result = Aoc2020.Day3.run(read_file_to_list("./test/day3/sample_input.txt"))

    assert result == 7
  end

  test "works for the provided list" do
    result = Aoc2020.Day3.run(read_file_to_list("./test/day3/input.txt"))

    assert result == 278
  end

  test "works for the provided sample for part 2" do
    result = Aoc2020.Day3.run_part_2(read_file_to_list("./test/day3/sample_input.txt"))

    assert result == 336
  end

  test "works for the provided list for part 2" do
    result = Aoc2020.Day3.run_part_2(read_file_to_list("./test/day3/input.txt"))

    assert result == 9709761600
  end
end
