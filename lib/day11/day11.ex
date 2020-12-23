defmodule Aoc2020.Day11 do
  defmodule Part1 do
    @doc """
    The rules for determining whether a seat must be filled or released seem much like a convolution
    with a convolution kernel like

    | -1 | -1 | -1 |
    | -1 | 3  | -1 |
    | -1 | -1 | -1 |

    So, I wrote a convolution util library
    """
    def run(input) do
      result =
        input
        |> process
        |> run_until_stable([])

      result
      |> count_seated
    end

    def run_until_stable(new_matrix, prev_matrix) when new_matrix == prev_matrix, do: new_matrix

    def run_until_stable(matrix, _) do
      new_matrix =
        matrix
        |> Util.Convolution.convolve([[-1, -1, -1], [-1, 3, -1], [-1, -1, -1]])
        |> fill_seats

      run_until_stable(new_matrix, matrix)
    end

    defp fill(nil), do: nil
    defp fill(x) when x >= 0, do: 1
    defp fill(x) when x < 0, do: 0

    defp fill_seats(matrix) do
      for row <- matrix, do: for(seat <- row, do: fill(seat))
    end

    defp is_seated(v) when is_number(v), do: v
    defp is_seated(_), do: 0

    defp count_seated(matrix) do
      matrix
      |> Enum.reduce(0, fn row, acc ->
        acc +
          Enum.reduce(row, 0, fn seat, acc ->
            acc + is_seated(seat)
          end)
      end)
    end

    defp process(input) do
      input |> Enum.map(&parse/1)
    end

    defp parse(line) do
      line
      |> String.graphemes()
      |> Enum.map(fn
        "." -> nil
        "L" -> 0
      end)
    end
  end
end
