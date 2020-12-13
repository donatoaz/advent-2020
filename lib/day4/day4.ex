defmodule Aoc2020.Day4 do
  require Logger

  defmodule Validator do
    @type reason :: String.t()
    @type result :: %{data: Enum.t(), errors: [reason()]}

    @heigh_limits [{~r/(?<height>\d+)cm$/, 150, 193}, {~r/(?<height>\d+)in$/, 59, 76}]

    @spec validate(Enum.t()) :: result()
    def validate(data) do
      result = %{
        data: data,
        errors: []
      }

      result
      |> validate_key(:byr, [required()])
      |> validate_key(:iyr, [required()])
      |> validate_key(:eyr, [required()])
      |> validate_key(:hgt, [required()])
      |> validate_key(:hcl, [required()])
      |> validate_key(:ecl, [required()])
      |> validate_key(:pid, [required()])
    end

    @doc """
    You can continue to ignore the cid field, but each other field has strict rules about what values are valid for automatic validation:

    byr (Birth Year) - four digits; at least 1920 and at most 2002.
    iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    hgt (Height) - a number followed by either cm or in:
    If cm, the number must be at least 150 and at most 193.
    If in, the number must be at least 59 and at most 76.
    hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    pid (Passport ID) - a nine-digit number, including leading zeroes.
    cid (Country ID) - ignored, missing or not.
    """
    def validate_part_2(data) do
      validate(data)
      |> validate_key(:byr, [between(1920, 2002)])
      |> validate_key(:iyr, [between(2010, 2020)])
      |> validate_key(:eyr, [between(2020, 2030)])
      |> validate_key(:hgt, [validate_height()])
      |> validate_key(:hcl, [validate_format(~r/#[0-9a-f]{6}/)])
      |> validate_key(:ecl, [validate_one_of(~w(amb blu brn gry grn hzl oth))])
      |> validate_key(:pid, [validate_format(~r/^\d{9}$/)])
    end

    defp validate_one_of(words) do
      fn value ->
        cond do
          !Enum.member?(words, value) -> {:invalid, "not in the list"}
          true -> :ok
        end
      end
    end

    defp validate_format(regex) do
      fn
        nil ->
          {:invalid, "required"}

        value ->
          cond do
            !String.match?(value, regex) -> {:invalid, "format does not match"}
            true -> :ok
          end
      end
    end

    defp between(low, high) do
      fn
        nil ->
          {:invalid, "invalid"}

        value ->
          case String.to_integer(value) do
            x when x < low -> {:invalid, "is too low"}
            x when x > high -> {:invalid, "is too high"}
            _ -> :ok
          end
      end
    end

    defp validate_height do
      fn
        nil ->
          {:invalid, "required field"}

        value ->
          case get_height_min_max(value) do
            {h, min, _} when h < min -> {:invalid, "invalid height"}
            {h, _, max} when h > max -> {:invalid, "invalid height"}
            _ -> :ok
          end
      end
    end

    defp get_height_min_max(value) do
      cond do
        String.match?(value, ~r/(cm|in)$/) ->
          {regex, min, max} =
            Enum.find(@heigh_limits, fn {regex, _, _} ->
              String.match?(value, regex)
            end)

          %{"height" => height} = Regex.named_captures(regex, value)

          {String.to_integer(height), min, max}

        true ->
          {0, 1, 1}
      end
    end

    defp required do
      fn
        "" -> {:invalid, "is required"}
        nil -> {:invalid, "is required"}
        _ -> :ok
      end
    end

    @spec validate_key(Enum.t(), atom(), list(fun())) :: none()
    defp validate_key(initial_result, key, validators) do
      value = get_in(initial_result, [:data, key])

      Enum.reduce(validators, initial_result, fn validator, result ->
        case validator.(value) do
          :ok ->
            result

          {:invalid, reason} ->
            update_in(result, [:errors, key], fn
              nil -> [reason]
              existing_reason -> [reason | existing_reason]
            end)
        end
      end)
    end
  end

  defp parse_input(input) do
    input
    |> Enum.map(fn e -> String.split(e, ~r/\s+/) end)
    |> Enum.map(fn doc ->
      Enum.reduce(doc, %{}, fn e, acc ->
        [k, v] = String.split(e, ":")
        Map.put(acc, String.to_atom(k), v)
      end)
    end)
  end

  def run(input) do
    parse_input(input)
    |> Enum.map(fn doc -> Validator.validate(doc) end)
    |> Enum.filter(fn e -> Enum.empty?(e.errors) end)
    |> Enum.count()
  end

  def run_part_2(input) do
    parse_input(input)
    |> Enum.map(fn doc -> Validator.validate_part_2(doc) end)
    |> Enum.filter(fn e -> Enum.empty?(e.errors) end)
    |> Enum.count()
  end
end
