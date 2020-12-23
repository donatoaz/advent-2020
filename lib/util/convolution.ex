defmodule Util.Convolution do
  @doc ~S"""
  Pads a matrix with n layers of value

  ## Examples

      iex> Util.Convolution.pad([[1,2],[3,4]], 0, 2)
      [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,1,2,0,0],[0,0,3,4,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]]

      iex> Util.Convolution.pad([[1,2],[3,4]], 0)
      [[0,0,0,0],[0,1,2,0],[0,3,4,0],[0,0,0,0]]
  """
  def pad(matrix, value, n \\ 1) do
    num_cols = matrix |> Enum.at(0) |> Enum.count()
    num_rows = matrix |> Enum.count()

    for _i <- 1..n do
      List.duplicate(value, num_cols + 2 * n)
    end ++
      for i <- 0..(num_rows - 1) do
        List.duplicate(value, n) ++ Enum.at(matrix, i) ++ List.duplicate(value, n)
      end ++
      for _ <- 1..n, do: List.duplicate(value, num_cols + 2 * n)
  end

  @doc ~S"""
  Performs 2d convolution of matrix with kernel

  ## Examples

      iex> Util.Convolution.convolve([[1,2,3],[4,5,6],[7,8,9]], [[-1,-2,-1],[0,0,0],[1,2,1]])
      [[-13,-20,-17],[-18,-24,-18],[13,20,17]]
  """
  def convolve(matrix, kernel) do
    k_h = ((kernel |> Enum.count()) - 1) |> div(2)
    k_w = ((kernel |> Enum.at(0) |> Enum.count()) - 1) |> div(2)

    for {row, i} <- Enum.with_index(matrix) do
      for {value, j} <- Enum.with_index(row) do
        case value do
          nil ->
            nil

          _ ->
            -k_h..k_h
            |> Enum.reduce(0, fn m, a ->
              a +
                (-k_w..k_w
                 |> Enum.reduce(0, fn n, b ->
                   k = kernel |> Enum.at(m + 1) |> Enum.at(n + 1)
                   v = matrix |> get(i - m, j - n)

                   b +
                     case v do
                       nil -> 0
                       _ -> k * v
                     end
                 end))
            end)
        end
      end
    end
  end

  defp get(_, i, _) when i < 0, do: 0
  defp get(_, _, j) when j < 0, do: 0
  defp get(m, i, _) when i >= length(m), do: 0
  defp get(m, _, j) when j >= length(m), do: 0
  defp get(m, i, j), do: m |> Enum.at(i) |> Enum.at(j)
end
