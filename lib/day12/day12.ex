defmodule Aoc2020.Day12 do
  defmodule Part1 do
    alias Aoc2020.Day12

    def run(input), do: input |> Day12.parse() |> navigate |> Day12.distance()

    def navigate(commands),
      do: commands |> Enum.reduce({:E, {0, 0}}, fn to, from -> navigate(from, to) end)

    def navigate({:E, {x, y}}, {:F, val}), do: {:E, {x + val, y}}
    def navigate({:W, {x, y}}, {:F, val}), do: {:W, {x - val, y}}
    def navigate({:S, {x, y}}, {:F, val}), do: {:S, {x, y - val}}
    def navigate({:N, {x, y}}, {:F, val}), do: {:N, {x, y + val}}

    def navigate({dir, {x, y}}, {:N, val}), do: {dir, {x, y + val}}
    def navigate({dir, {x, y}}, {:S, val}), do: {dir, {x, y - val}}
    def navigate({dir, {x, y}}, {:E, val}), do: {dir, {x + val, y}}
    def navigate({dir, {x, y}}, {:W, val}), do: {dir, {x - val, y}}

    def navigate({:E, {x, y}}, {:R, 90}), do: {:S, {x, y}}
    def navigate({:E, {x, y}}, {:R, 180}), do: {:W, {x, y}}
    def navigate({:E, {x, y}}, {:R, 270}), do: {:N, {x, y}}

    def navigate({:W, {x, y}}, {:R, 90}), do: {:N, {x, y}}
    def navigate({:W, {x, y}}, {:R, 180}), do: {:E, {x, y}}
    def navigate({:W, {x, y}}, {:R, 270}), do: {:S, {x, y}}

    def navigate({:S, {x, y}}, {:R, 90}), do: {:W, {x, y}}
    def navigate({:S, {x, y}}, {:R, 180}), do: {:N, {x, y}}
    def navigate({:S, {x, y}}, {:R, 270}), do: {:E, {x, y}}

    def navigate({:N, {x, y}}, {:R, 90}), do: {:E, {x, y}}
    def navigate({:N, {x, y}}, {:R, 180}), do: {:S, {x, y}}
    def navigate({:N, {x, y}}, {:R, 270}), do: {:W, {x, y}}

    def navigate(from, {:L, 90}), do: navigate(from, {:R, 270})
    def navigate(from, {:L, 180}), do: navigate(from, {:R, 180})
    def navigate(from, {:L, 270}), do: navigate(from, {:R, 90})
  end

  defmodule Part2 do
    alias Aoc2020.Day12

    def run(input), do: input |> Day12.parse() |> navigate |> Day12.distance()

    def navigate(commands),
      do: commands |> Enum.reduce({{10, 1}, {0, 0}}, fn to, from -> navigate(from, to) end)

    def navigate({{wx, wy}, {x, y}}, {:F, val}), do: {{wx, wy}, {x + wx * val, y + wy * val}}

    def navigate({{wx, wy}, {x, y}}, {:N, val}), do: {{wx, wy + val}, {x, y}}
    def navigate({{wx, wy}, {x, y}}, {:S, val}), do: {{wx, wy - val}, {x, y}}
    def navigate({{wx, wy}, {x, y}}, {:E, val}), do: {{wx + val, wy}, {x, y}}
    def navigate({{wx, wy}, {x, y}}, {:W, val}), do: {{wx - val, wy}, {x, y}}

    def navigate({{wx, wy}, {x, y}}, {:R, 90}), do: {{wy, -wx}, {x, y}}
    def navigate({{wx, wy}, {x, y}}, {:R, 180}), do: {{-wx, -wy}, {x, y}}
    def navigate({{wx, wy}, {x, y}}, {:R, 270}), do: {{-wy, wx}, {x, y}}

    def navigate({{wx, wy}, {x, y}}, {:L, 90}), do: {{-wy, wx}, {x, y}}
    def navigate({{wx, wy}, {x, y}}, {:L, 180}), do: {{-wx, -wy}, {x, y}}
    def navigate({{wx, wy}, {x, y}}, {:L, 270}), do: {{wy, -wx}, {x, y}}
  end

  def distance({_, {x, y}}), do: abs(x) + abs(y)

  def parse(input), do: input |> parse_cmd

  def parse_cmd([]), do: []

  def parse_cmd([<<cmd::binary-size(1)>> <> val | tail]),
    do: [{String.to_atom(cmd), String.to_integer(val)} | parse_cmd(tail)]
end
