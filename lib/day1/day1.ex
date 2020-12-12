defmodule Aoc2020.Day1 do
  require Logger

  def run(input) do
    # Specifically, they need you to find the two entries that sum to 2020 and then multiply
    #  those two numbers together

    # build a map that gets me the 2020's complement
    adds_to_2020 = build_complement_list(input, 2020)

    # get the first entry that exists in the input
    num = input
      |> Enum.filter(fn e -> Map.has_key?(adds_to_2020, e) end)
      |> List.first()

    num * Map.get(adds_to_2020, num)
  end

  def run_part_2(input) do
    # In your expense report, what is the product of the three entries that sum to 2020?

    # basically what we want is x + y + z = 2020. We can split this problem in finding
    #  x + y = 2020 - z, for z being every element in the input
    #  then we solve the x + y = k, where k = 2020 - z

    # builds a map of 2020 - z -> z, where z is an original element of the list, and 2020 - z = k
    adds_to_2020 = build_complement_list(input, 2020)
    k = Map.keys(adds_to_2020)

    adds_to_k = k
      |> Enum.map(fn e -> build_complement_list(input, e) end)

    {x, y} = adds_to_k
      |> Enum.map(fn e -> filter_list_from_map(input, e) end)
      |> Enum.reject(fn {a,_} -> a == nil end)
      |> List.first()

    z = Map.get(adds_to_2020, x + y)

    (x * y) * z
  end

  defp build_complement_list(list, n) do
    list |> Enum.map(fn e -> {n - e, e} end) |> Map.new
  end

  defp filter_list_from_map(list, map) do
    num = list |> Enum.filter(fn e -> Map.has_key?(map, e) end) |> List.first()

    {num, Map.get(map, num)}
  end
end
