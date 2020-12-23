ExUnit.start(exclude: [:skip])

defmodule Helpers do
  def read_file_to_list(path) do
    {:ok, content} = File.read(path)

    content
    |> String.split("\n", trim: true)
  end

  def read_file_to_list_of_int(path) do
    read_file_to_list(path)
    |> Enum.map(&String.to_integer/1)
  end
end
