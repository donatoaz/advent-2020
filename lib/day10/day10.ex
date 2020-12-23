defmodule Aoc2020.Day10 do
  defmodule Part1 do
    def run(input) do
      hops =
        input
        |> Enum.sort()
        |> Stream.chunk_every(2, 1, :discard)
        |> Enum.map(fn [x, y] -> y - x end)
        |> Enum.reduce(%{}, fn e, map -> Map.put(map, e, Map.get(map, e, 1) + 1) end)

      Map.get(hops, 1) * Map.get(hops, 3)
    end
  end

  defmodule Part2 do
    def run(input) do
      # Idea here is to build a Directed Acyclic Graph (dag) and then apply one algorithm that counts the total
      #  number of paths for this dag
      adapter_max_joltage = Enum.max(input)

      # pads input with the outlet joltage and the device built-in adapter joltage
      input = [0] ++ input ++ [adapter_max_joltage + 3]

      # We'll use an agent to memoize our calculated paths. The agent will keep a map as state
      {:ok, memo} = Agent.start(fn -> %{} end)

      build_edges(input, :flat)
      |> build_graph
      |> num_paths(0, adapter_max_joltage, memo)
    end

    def num_paths(_, i, j, _) when i == j, do: 1

    def num_paths(graph, i, j, memo) do
      graph
      |> Map.get(i)
      |> Enum.reduce(0, fn k, acc ->
        acc +
          case Agent.get(memo, &Map.get(&1, {k, j})) do
            nil ->
              result = num_paths(graph, k, j, memo)
              Agent.update(memo, &Map.put(&1, {k, j}, result))
              result

            result ->
              result
          end
      end)
    end

    def build_graph(edges) do
      edges
      |> Enum.reduce(%{}, fn [source, dest], map ->
        map |> Map.update(source, [dest], fn current -> current ++ [dest] end)
      end)
    end

    @doc ~S"""
    Builds a list of lits of nodes for Directed Acyclic Graph from input
    A given node i is connected to node j if the hop distance is less then 3 (adapter input rating constraint)
    A given node can only be connected to at most 3 other nodes (a result of above corollary), so we will do a sliding window with n = 4

    Returns a list of edges where each edge is a tuple {i,j} indicating there is a connection between
    nodes i and j

    ## Examples

        iex> Aoc2020.Day10.Part2.build_edges([16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4])
        [[[1, 4]],[[4, 5],[4, 6],[4, 7]],[[5, 6],[5, 7]],[[6, 7]],[[7, 10]],[[10, 11],[10, 12]],[[11, 12]],[[12, 15]],[[15, 16]]]
    """
    def build_edges(input) do
      input
      |> Enum.sort()
      |> Stream.chunk_every(4, 1)
      |> Enum.map(fn [i | tail] ->
        for j <- tail, j - i <= 3, do: [i, j]
      end)
    end

    @doc ~S"""
    Returns a flat list of nodes given a list of lists of nodes

    ## Examples

        iex> Aoc2020.Day10.Part2.build_edges([16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4], :flat)
        [[1, 4],[4, 5],[4, 6],[4, 7],[5, 6],[5, 7],[6, 7],[7, 10],[10, 11],[10, 12],[11, 12],[12, 15],[15, 16]]
    """
    def build_edges(input, :flat) do
      build_edges(input)
      |> List.foldl([], &(&2 ++ &1))
    end
  end
end
