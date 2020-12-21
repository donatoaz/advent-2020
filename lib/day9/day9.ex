defmodule Aoc2020.Day9 do
  defmodule Part1 do
    alias Aoc2020.Day9

    @doc """
    We will perform a sliding window on the input, with a window size of preamble_size + 1
    The "+1" is the subject which we will check XMAS validity for

    We reverse the chunks because I think elixir only matches [head | tail] and not [body| last]

    The we will filter for invalid xmases and return the first subject found
    """
    def run(input, preamble_size) do
      input
      |> Stream.chunk_every(preamble_size + 1, 1, :discard)
      |> Enum.map(&Enum.reverse/1)
      |> Enum.filter(fn [subject | preamble] ->
        Day9.invalid_xmas?(subject, preamble)
      end)
      |> List.flatten()
      |> List.first()
    end
  end

  defmodule Part2 do
    @doc """
    We will retrieve the result from part 1, then we will iteratevely check, using brute force, every consecutive
    k-element combination, starting with 2, for the summation matching the target (result from part 1)

    Our function evaluate_until_successful will return the first k-element combination, for which we want to calculate
    the sum of its max and min elements.
    """
    def run(input, preamble_size) do
      target = Part1.run(input, preamble_size)

      evaluate_until_successful(input, target, 2)
      |> Enum.min_max()
      |> Tuple.to_list()
      |> Enum.sum()
    end

    # Recursevely search list, calling itself with increasing k at each iteration
    defp evaluate_until_successful(list, target, k) do
      case evaluate_sum_by(list, target, k) do
        nil -> evaluate_until_successful(list, target, k + 1)
        result -> result
      end
    end

    # Given an input list, it chunks it k by k contiguous elements until if finds a k-element list that
    # adds up to target
    defp evaluate_sum_by(list, target, k) do
      list
      |> Stream.chunk_every(k, 1, :discard)
      |> Enum.find(fn e -> Enum.sum(e) == target end)
    end
  end

  @doc """
  given a subject and a preamble list, this method will verify if any combination 2-by-2 of preamble elements
  add up to subject. If none are found it returns true.
  """
  def invalid_xmas?(subject, preamble) do
    valid =
      combinations(preamble, 2)
      |> Enum.any?(fn [x, y] -> valid_xmas?(subject, x, y) end)

    !valid
  end

  defp valid_xmas?(subject, x, y) when subject == x + y, do: true
  defp valid_xmas?(_, _, _), do: false

  @doc """
  These a degenerate cases of permutations: the permitations of an empty list, regardless of by how many
  elements, is an empty list result
  """
  def permutations([], _), do: [[]]

  @doc """
  Another degenerate case of permutation: the permutations of any size list 0 by 0 elements is also an empty
  list result.
  """
  def permutations(_, 0), do: [[]]

  @doc """
  This is the general case: the permutations k by k of a list is recursevely a list of lists starting with
  each element appended by the permutation (k-1) by (k-1) of all elements
  """
  def permutations(list, k) do
    for head <- list, tail <- permutations(list, k - 1), do: [head | tail]
  end

  @doc """
  This is an exploitation of the general case of permutations, whereby a combination of k by k elements,
  which does not accept repetitions is recursevely a list of lists starting with each element appended by
  the permutation (k-1) by (k-1) of the remaining elements (thus the -- operation)
  """
  def combinations(list, k) do
    for head <- list, tail <- permutations(list -- [head], k - 1), do: [head | tail]
  end
end
