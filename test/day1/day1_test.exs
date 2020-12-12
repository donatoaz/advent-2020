defmodule Aoc2020test.Day1 do
  require Logger
  use ExUnit.Case
  doctest Aoc2020.Day1

  defp read_file_to_list_of_int(path) do
    {:ok, content} = File.read(path)

    content
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  test "works for sample list" do
    sample_list = [1721,979,366,299,675,1456]

    assert Aoc2020.Day1.run(sample_list) == 514579
  end

  test "works for the provided list" do
    list = read_file_to_list_of_int("./test/day1/input.txt")

    result = Aoc2020.Day1.run(list)
    # Logger.debug inspect(list)

    assert result == 1020036
  end

  test "works for sample of part 2" do
    sample_list = [1721,979,366,299,675,1456]

    assert Aoc2020.Day1.run_part_2(sample_list) == 241861950
  end

  test "works for the provided list for part 2" do
    list = read_file_to_list_of_int("./test/day1/input.txt")

    result = Aoc2020.Day1.run_part_2(list)

    assert result == 286977330
  end
end
