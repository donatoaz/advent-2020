defmodule Aoc2020.Day6 do
  require Logger

  def run(input) do
    input
    |> Enum.map(fn group ->
      group
      |> Enum.reduce([], fn answers, acc -> [String.graphemes(answers) | acc] end)
      |> List.flatten()
      |> Enum.uniq()
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  @doc """
  You don't need to identify the questions to which anyone answered "yes"; you need to identify
  the questions to which everyone answered "yes"!

  For each group, count the number of questions to which everyone answered "yes". What is the sum of those counts?
  """
  def run_part_2(groups) do
    groups
    |> Enum.map(&process/1)
    |> Enum.sum()
  end

  defp process(group) do
    group
    |> Enum.reduce([], fn answers, acc -> [String.graphemes(answers) | acc] end)
    |> Enum.reduce(fn list, acc -> acc -- acc -- list end)
    |> Enum.count()
  end
end
