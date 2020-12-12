defmodule Aoc2020.Day3 do
  require Logger

  @tree "#"
  @open "."
  # @right 3 # three to the right, one down
  # @down 1

  # defp is_tree(nil), do: 0
  defp is_tree(@tree), do: 1
  defp is_tree(@open), do: 0

  # we've reached the end of the slope
  defp descend(list, _, y, _, _) when y >= length(list), do: 0

  # first position does not count (or does it??)
  defp descend(list, 0, 0, right, down), do: descend(list, right, down, right, down)

  defp descend(list, x, y, right, down) do
    # the horizontal size dictates how our world "replicates"
    horizontal_size = String.length(List.first(list))

    position = list
      |> Enum.at(y) # we'll go down first (name of your sex tape... 99!)
      |> String.at(x)

    new_x = rem(x + right, horizontal_size)
    new_y = y + down

    # Logger.debug inspect({x, y, new_x, new_y, position, horizontal_size, length(list)})

    is_tree(position) + descend(list, new_x, new_y, right, down)
  end

  def run(input) do
    right = 3
    down = 1
    num_trees = descend(input, 0, 0, right, down)

    # Logger.debug inspect(num_trees)

    num_trees
  end

  @doc """
  Determine the number of trees you would encounter if, for each of the following slopes, you start at the top-left corner and traverse the map all the way to the bottom:

  Right 1, down 1.
  Right 3, down 1. (This is the slope you already checked.)
  Right 5, down 1.
  Right 7, down 1.
  Right 1, down 2.

  In the above example, these slopes would find 2, 7, 3, 4, and 2 tree(s) respectively; multiplied together, these produce the answer 336.

  What do you get if you multiply together the number of trees encountered on each of the listed slopes?
  """
  def run_part_2(input) do
    slopes = [
      {1,1},
      {3,1},
      {5,1},
      {7,1},
      {1,2}
    ]

    slopes
    |> Enum.map(fn {right, down} -> descend(input, 0, 0, right, down) end)
    |> Enum.reduce(fn x, acc -> x * acc end)
  end
end
