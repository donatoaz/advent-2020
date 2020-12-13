defmodule Aoc2020.Day7 do
  require Logger

  defp build_bag_map(input) do
    input
    |> Enum.map(&parse/1)
    |> Enum.reduce(%{}, fn
      nil, map -> map
      e, map -> Map.merge(map, e)
    end)
  end

  def run(input, holdee) do
    bag_map = build_bag_map(input)

    bag_map
    |> Map.keys()
    |> Enum.filter(fn holder ->
      can_hold?(bag_map, Map.get(bag_map, holder), holdee)
    end)
    |> Enum.count()
  end

  defp can_hold?(bag_map, holdees, holdee) do
    Map.has_key?(holdees, holdee) ||
      holdees
      |> Map.keys()
      |> Enum.reduce(false, fn holder, acc ->
        acc || can_hold?(bag_map, get_in(bag_map, [holder]), holdee)
      end)
  end

  def run_part_2(input, holdee) do
    bag_map = build_bag_map(input)

    bag_map |> process(Map.get(bag_map, holdee))
  end

  defp process(_, holdees) when holdees == %{}, do: 0

  defp process(bag_map, holdees) do
    holdees
    |> Enum.reduce(0, fn {k, v}, acc ->
      v + acc + v * process(bag_map, get_in(bag_map, [k]))
    end)
  end

  defp parse(phrase) do
    # EXAMPLE PHRASE: light red bags contain 1 bright white bag, 2 muted yellow bags.
    %{"bag_type" => bag_type, "contains" => contains} =
      ~r/(?<bag_type>^[\w\s]+) bags contain (?<contains>.*)\./
      |> Regex.named_captures(phrase)

    # EXAMPLE CONTAINS: 1 bright white bag, 2 muted yellow bags
    containment =
      contains
      # EXAMPLE CONTAIN: 1 bright white bag
      |> String.split(", ", trim: true)
      |> Enum.map(fn e ->
        Regex.named_captures(~r/(?<quantity>\d+) (?<bag_type>[\w\s]+) bag/, e)
        |> parse_contained()
      end)
      |> Enum.reduce(%{}, fn
        nil, map -> map
        e, map -> Map.merge(map, e)
      end)

    %{bag_type => containment}
  end

  defp parse_contained(nil), do: nil

  defp parse_contained(%{"bag_type" => bag, "quantity" => qty}) do
    %{bag => String.to_integer(qty)}
  end
end
