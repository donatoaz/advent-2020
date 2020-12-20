defmodule Aoc2020.Day8 do
  require Logger

  defmodule Part1 do
    alias Aoc2020.Day8

    def run(input) do
      program = Day8.build_program(input)
      Day8.process(program, %{}, false, 0, 0, Map.get(program, 0))
    end
  end

  defmodule Part2 do
    alias Aoc2020.Day8

    def run(input) do
      program = Day8.build_program(input)

      run_until_successful(
        program,
        program,
        :maps.filter(fn _, v -> elem(v, 0) in [:jmp, :nop] end, program)
      )
    end

    defp run_until_successful(program, original_program, change_options) do
      case Day8.process(program, %{}, false, 0, 0, Map.get(program, 0)) do
        {:infinite_loop, _} ->
          {new_program, change_options} = change_program(original_program, change_options)

          run_until_successful(new_program, original_program, change_options)

        {:ok, acc} ->
          {:ok, acc}
      end
    end

    # Changes the program by switching a single NOP (or JMP) command at a time. It accepts a map of change options which must
    # be a map of %{pc => {:cmd, arg}}. It will change a random command by picking a random key from the change_options map.
    defp change_program(program, change_options) do
      changed_instruction = change_options |> Map.keys() |> Enum.random()
      {instruction, remaining_options} = Map.pop(change_options, changed_instruction)

      {Map.put(program, changed_instruction, do_switch(instruction)), remaining_options}
    end

    # Converts JMP commands to NOP commands and vice-versa
    defp do_switch({:jmp, arg}), do: {:nop, arg}
    defp do_switch({:nop, arg}), do: {:jmp, arg}
  end

  @doc """
  Processes an instruction when we're seeing the same instruction for the second time, which means we're in an infinite loop.

  Return a tuple with :infinite_loop and the accumulator value.
  """
  def process(_, _, true, acc, _, _), do: {:infinite_loop, acc}

  @doc """
  Processes an instruction when the program counter exceeds the program size, which means we've sucessfuly ran the program

  Return a tuple with :ok and the accumulator value.
  """
  def process(program, _, _, acc, pc, _) when pc >= map_size(program), do: {:ok, acc}

  @doc """
  Processess a NOP instruction (does nothing), mark the program counter (pc) as visited and move on to next instruction

  The instruction immediately below it is executed next.
  """
  def process(program, visited_map, _, acc, pc, {:nop, _}) do
    visited_map = Map.put(visited_map, pc, true)
    next_instruction = pc + 1

    process(
      program,
      visited_map,
      Map.has_key?(visited_map, next_instruction),
      acc,
      next_instruction,
      Map.get(program, next_instruction)
    )
  end

  @doc """
  Processes an ACC instruction, which adds to the accummulator (acc) the argument passed in to :acc command.

  After an acc instruction, the instruction immediately below it is executed next.
  """
  def process(program, visited_map, _, acc, pc, {:acc, arg}) do
    visited_map = Map.put(visited_map, pc, true)
    next_instruction = pc + 1

    process(
      program,
      visited_map,
      Map.has_key?(visited_map, next_instruction),
      acc + arg,
      next_instruction,
      Map.get(program, next_instruction)
    )
  end

  @doc """
  Processes a JMP instruction, which simply jumps to the offset passed as the argument to the :jmp command.
  """
  def process(program, visited_map, _, acc, pc, {:jmp, offset}) do
    # IO.inspect(visited_map, label: "visited map")
    # IO.inspect(acc, label: "accum")

    visited_map = Map.put(visited_map, pc, true)

    next_instruction = pc + offset

    process(
      program,
      visited_map,
      Map.has_key?(visited_map, next_instruction),
      acc,
      next_instruction,
      Map.get(program, next_instruction)
    )
  end

  @doc ~S"""
  Constructs a map of instructions given a list of string instructions. Map keys are the program counter (pc)
  and values are a tuple of command (cmd) and argument (arg).

  ## Examples

      iex> Aoc2020.Day8.build_program(["nop +0", "acc -1"])
      %{0 => {:nop, 0}, 1 => {:acc, -1}}
  """
  def build_program(input) do
    input
    |> Enum.map(&parse/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {cmd, i}, map -> Map.put(map, i, cmd) end)
  end

  @doc ~S"""
  parse receives a well formated string (command with 3 characters, a white space and a trailing signed integer)
  returns a tuple with {command, integer}

  ## Examples

      iex> Aoc2020.Day8.parse("acc -99")
      {:acc, -99}

      iex> Aoc2020.Day8.parse("jmp +20")
      {:jmp, 20}
  """
  def parse(<<cmd::binary-size(3), _::binary-size(1), arg::binary>>) do
    {String.to_atom(cmd), elem(Integer.parse(arg), 0)}
  end
end
