defmodule Aoc2020.Day2 do
  require Logger

  defmodule Term do
    defstruct min: "", max: "", character: "", password: ""
  end

  defp build_struct(list) do
    regex = ~r/(?<min>\d+)-(?<max>\d+)\s*(?<character>\w): (?<password>\w+)/

    list
    # parse string
    |> Enum.map(fn e -> Regex.named_captures(regex, e) end)
    # convert keys to atoms
    |> Enum.map(fn e -> Map.new(e, fn {k, v} -> {String.to_atom(k), v} end) end)
    # create a struct to make it easier to work
    |> Enum.map(fn e -> struct(Term, e) end)
  end

  defp part_1_predicate(term) do
    count =
      term.password
      |> String.graphemes()
      |> Enum.count(&(&1 == term.character))

    count >= String.to_integer(term.min) && count <= String.to_integer(term.max)
  end

  defp part_2_predicate(term) do
    # (Be careful; Toboggan Corporate Policies have no concept of "index zero"!)

    a = String.at(term.password, String.to_integer(term.min) - 1) == term.character
    b = String.at(term.password, String.to_integer(term.max) - 1) == term.character

    (a && !b) || (!a && b)
  end

  def run(input) do
    # Each line gives the password policy and then the password. The password policy indicates
    #  the lowest and highest number of times a given letter must appear for the password to be valid.
    #  For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.
    terms = build_struct(input)

    valid_terms =
      terms
      |> Enum.filter(&part_1_predicate/1)

    Enum.count(valid_terms)
  end

  def run_part_2(input) do
    terms = build_struct(input)

    valid_terms = terms |> Enum.filter(&part_2_predicate/1)

    Enum.count(valid_terms)
  end
end
