defmodule Aoc2020.Day14 do
  defmodule Part1 do
    alias Aoc2020.Day14

    @doc """
    We will be receiving a list of strings that may contain two distinct types:
    1) mask = \w{36} consisting of "mask = " followed by 36 characters that can either by 'X', '0' or '1'
    2) mem[\d+] = \d+ consisting of "mem[number] = number" where the first number is a memory addr and the second
       is a value to write to the address

    We will parse the input, string by string, matching each to the appropriate parse function, passing
      around the state (mask and memmory)
    """
    def run(input) do
      input |> parse("", %{}) |> Day14.sum()
    end

    defp parse([], _, mem), do: mem
    defp parse(["mask = " <> value | tail], _, mem), do: parse(tail, value, mem)

    defp parse([cmd | tail], mask, mem) do
      regex = ~r/mem\[(?<position>\d+)\] = (?<value>\d+)/
      %{"position" => position, "value" => value} = Regex.named_captures(regex, cmd)

      parse(tail, mask, Map.put(mem, position, value |> apply_mask(mask) |> String.to_integer(2)))
    end

    defp apply_mask(value, mask) do
      value = Day14.convert_to_36bit_binary(value)

      List.zip([value |> String.graphemes(), mask |> String.graphemes()])
      |> Enum.map(&mask/1)
      |> Enum.join()
    end

    defp mask({_, "1"}), do: "1"
    defp mask({_, "0"}), do: "0"
    defp mask({v, "X"}), do: v
  end

  defmodule Part2 do
    alias Aoc2020.Day14

    @doc """
    A version 2 decoder chip doesn't modify the values being written at all. Instead, it acts as a memory address decoder. Immediately before a value is written to memory, each bit in the bitmask modifies the corresponding bit of the destination memory address in the following way:

    * If the bitmask bit is 0, the corresponding memory address bit is unchanged.
    * If the bitmask bit is 1, the corresponding memory address bit is overwritten with 1.
    * If the bitmask bit is X, the corresponding memory address bit is floating.

    We will add an additional step before writing to memory to spread writes accross all possible floating memory values
    """
    def run(input) do
      input |> parse("", %{}) |> Day14.sum()
    end

    defp parse([], _, mem), do: mem
    defp parse(["mask = " <> value | tail], _, mem), do: parse(tail, value, mem)

    defp parse([cmd | tail], mask, mem) do
      regex = ~r/mem\[(?<position>\d+)\] = (?<value>\d+)/
      %{"position" => position, "value" => value} = Regex.named_captures(regex, cmd)

      parse(tail, mask, write_to_memory(mem, position |> apply_mask(mask), value))
    end

    defp write_to_memory(mem, position, value) do
      position
      |> spread
      |> Enum.map(&String.to_integer(&1, 2))
      |> Enum.reduce(mem, fn pos, mem ->
        mem |> Map.put(pos, value |> Day14.convert_to_36bit_binary() |> String.to_integer(2))
      end)
    end

    @doc ~S"""
    Spreads the floating positions into actual positions

    ## Examples

        iex> Aoc2020.Day14.Part2.spread("000000000000000000000000000000X1101X")
        ["000000000000000000000000000000011010", "000000000000000000000000000000011011", "000000000000000000000000000000111010", "000000000000000000000000000000111011"]
    """
    def spread(position) do
      position
      |> String.graphemes()
      |> Enum.reduce([], fn
        "X", [] ->
          ["0", "1"]

        char, [] ->
          [char]

        "X", positions ->
          positions
          |> Enum.map(fn position -> [position <> "0", position <> "1"] end)
          |> List.flatten()

        char, positions ->
          positions |> Enum.map(&(&1 <> char))
      end)
    end

    defp apply_mask(value, mask) do
      value = Day14.convert_to_36bit_binary(value)

      List.zip([value |> String.graphemes(), mask |> String.graphemes()])
      |> Enum.map(&mask/1)
      |> Enum.join()
    end

    defp mask({_, "1"}), do: "1"
    defp mask({v, "0"}), do: v
    defp mask({_, "X"}), do: "X"
  end

  def convert_to_36bit_binary(str) do
    str |> String.to_integer() |> Integer.to_string(2) |> String.pad_leading(36, "0")
  end

  def sum(mem), do: mem |> Map.values() |> Enum.sum()
end
