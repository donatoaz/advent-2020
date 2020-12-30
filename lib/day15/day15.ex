defmodule Aoc2020.Day15 do
  defmodule Part1 do
    def run(input, max_turns) do
      input |> parse |> play(nil, 1, max_turns, %{})
    end

    # this is the stop condition for the recursion
    defp play(_, last_spoken, turn, max_turns, _) when turn > max_turns, do: last_spoken

    # this function is called on the first turn, thus the nil for the last_spoken parameter
    #  (since at turn 1 there is no last_spoken)
    defp play([number | tail], nil, turn, max_turns, _),
      do: play(tail, number, turn + 1, max_turns, %{})

    # this function is called in the initial turns, while we are "seeding" the recitation
    defp play([number | tail], last_spoken, turn, max_turns, mem),
      do: play(tail, number, turn + 1, max_turns, Map.put(mem, last_spoken, turn - 1))

    # after seeding is done, the game "begins"
    defp play([], spoken, turn, max_turns, mem),
      do:
        play(
          [],
          speak(spoken, turn - 1, mem),
          turn + 1,
          max_turns,
          Map.put(mem, spoken, turn - 1)
        )

    defp speak(number, prev_turn, mem) do
      case Map.get(mem, number) do
        nil -> 0
        last_turn_it_was_spoken -> prev_turn - last_turn_it_was_spoken
      end
    end

    @doc ~S"""
    Parses input

    ## Examples

        iex> Aoc2020.Day15.Part1.parse("1,2,3")
        [1,2,3]
    """
    def parse(input), do: input |> String.split(",") |> Enum.map(&String.to_integer/1)
  end
end
