defmodule Aoc2020.Day5 do
  require Logger

  defp parse(<<row::binary-size(7), aisle::binary>>) do
    {row |> String.replace("B", "1") |> String.replace("F", "0") |> Integer.parse(2) |> elem(0),
     aisle |> String.replace("R", "1") |> String.replace("L", "0") |> Integer.parse(2) |> elem(0)}
  end

  defp gen_ids(input) do
    input
    |> Enum.map(&parse/1)
    |> Enum.map(fn {row, aisle} -> row * 8 + aisle end)
  end

  def run(input) do
    gen_ids(input)
    |> Enum.max()
  end

  @doc """
  It's a completely full flight, so your seat should be the only missing boarding pass in your list.
  However, there's a catch: some of the seats at the very front and back of the plane don't exist on
  this aircraft, so they'll be missing from your list as well.

  Your seat wasn't at the very front or back, though; the seats with IDs +1 and -1 from yours will be
  in your list.

  What is the ID of your seat?

  If we subtract the sum of our ids from the sum of all natural numbers from
  the first id to the last id we shall get the only missing id
  """
  def run_part_2(input) do
    ids = gen_ids(input)

    min_id = ids |> Enum.min()
    max_id = ids |> Enum.max()

    sum_ids = ids |> Enum.sum()
    sum_n = min_id..max_id |> Enum.sum()

    sum_n - sum_ids
  end
end
