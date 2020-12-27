defmodule Aoc2020.Day13 do
  defmodule Part1 do
    def run(input),
      do: input |> parse |> IO.inspect() |> calc_distances |> IO.inspect() |> min |> cost

    defp cost({earliest, bus_id, time}), do: bus_id * (time - earliest)

    defp min(distances), do: distances |> Enum.min_by(fn {_, _, dist} -> dist end)

    defp calc_distances({earliest, bus_ids}),
      do:
        bus_ids
        |> Enum.map(fn bus_id -> {earliest, bus_id, div(earliest, bus_id) * bus_id + bus_id} end)

    defp parse([earliest | [ids | _]]),
      do: {earliest |> String.to_integer(), parse_bus_ids(ids |> String.split(",", trim: true))}

    defp parse_bus_ids([]), do: []
    defp parse_bus_ids(["x" | tail]), do: parse_bus_ids(tail)
    defp parse_bus_ids([head | tail]), do: [head |> String.to_integer() | parse_bus_ids(tail)]
  end

  @doc """
  The idea here is, given a set of ids K, with elements k_0, k_1, ..., k_n, to find a number t
  such that rem(t, k_0) == 0, rem(t+1, k_1) == 0, ..., rem(t+n, k_n) ==0

  The challenge suggest that our t will start beyond 100_000_000_000_000, could we use it to our advantage?


  """
  defmodule Part2 do
    def run([_ | bus_ids]) do
      [{first_bus, _} | other_buses] = bus_ids |> parse

      other_buses
      |> find_min_time(0, first_bus)
    end

    defp find_min_time([], time, _), do: time

    defp find_min_time(buses = [{bus, delta} | remaining_buses], time, step_size) do
      cond do
        rem(time + delta, bus) != 0 -> find_min_time(buses, time + step_size, step_size)
        true -> find_min_time(remaining_buses, time, step_size * bus)
      end
    end

    defp parse([ids | _]) do
      ids
      |> String.split(",", trim: true)
      |> Enum.with_index()
      |> Enum.filter(fn {x, _} -> x != "x" end)
      |> Enum.map(fn {x, i} -> {String.to_integer(x), i} end)
    end
  end
end
