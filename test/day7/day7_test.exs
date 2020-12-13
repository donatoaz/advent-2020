defmodule Aoc2020test.Day7 do
  require Logger
  use ExUnit.Case
  doctest Aoc2020.Day7

  defp read_file_to_list(path) do
    {:ok, content} = File.read(path)

    content
    |> String.split("\n", trim: true)
  end

  test "it works for the provided sample" do
    input = read_file_to_list("./test/day7/sample_input.txt")

    assert Aoc2020.Day7.run(input, "shiny gold") == 4
  end

  test "it works for the provided input file" do
    input = read_file_to_list("./test/day7/input.txt")

    assert Aoc2020.Day7.run(input, "shiny gold") == 144
  end

  test "it works for the provided sample file of part 2" do
    input = read_file_to_list("./test/day7/sample_input.txt")

    assert Aoc2020.Day7.run_part_2(input, "shiny gold") == 32
  end

  test "it works for the second provided sample file of part 2" do
    input = read_file_to_list("./test/day7/sample_input2.txt")

    assert Aoc2020.Day7.run_part_2(input, "shiny gold") == 126
  end

  test "it works for the provided input of part 2" do
    input = read_file_to_list("./test/day7/input.txt")

    assert Aoc2020.Day7.run_part_2(input, "shiny gold") == 5956
  end
end
