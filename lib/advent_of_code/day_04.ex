defmodule AdventOfCode.Day04 do
  def part1(input) do
    input
    |> format_input()
    |> Enum.map(&validate_required(&1))
    |> Enum.count(fn x -> x == true end)
  end

  def part2(input) do
    input
    |> format_input()
    |> Enum.map(fn x ->
      x
      |> validate_required()
      |> validate_params(x)
    end)
    |> Enum.count(fn x -> x == true end)
  end

  defp format_input(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&to_map(&1))
  end

  defp to_map(params) do
    params
    |> String.trim()
    |> String.split(["\n", " "])
    |> Enum.reduce(%{}, fn field, result ->
      [key, value] = String.split(field, [":", " "])
      Map.put(result, key, value)
    end)
  end

  defp validate_required(%{
         "byr" => _,
         "iyr" => _,
         "eyr" => _,
         "hgt" => _,
         "hcl" => _,
         "ecl" => _,
         "pid" => _
       }) do
    true
  end

  defp validate_required(_), do: false

  defp validate_params(false, _), do: false

  defp validate_params(true, params) do
    params
    |> validate_byr()
    |> validate_iyr(params)
    |> validate_eyr(params)
    |> validate_hgt(params)
    |> validate_hcl(params)
    |> validate_ecl(params)
    |> validate_pid(params)
  end

  defp validate_byr(%{"byr" => byr}) do
    if String.length(byr) == 4 and String.to_integer(byr) >= 1920 and
         String.to_integer(byr) <= 2002 do
      true
    else
      false
    end
  end

  defp validate_iyr(true, %{"iyr" => iyr}) do
    if String.length(iyr) == 4 and String.to_integer(iyr) >= 2010 and
         String.to_integer(iyr) <= 2020 do
      true
    else
      false
    end
  end

  defp validate_iyr(false, _params), do: false

  defp validate_eyr(true, %{"eyr" => eyr}) do
    if String.length(eyr) == 4 and String.to_integer(eyr) >= 2020 and
         String.to_integer(eyr) <= 2030 do
      true
    else
      false
    end
  end

  defp validate_eyr(false, _params), do: false

  defp validate_hgt(true, %{"hgt" => hgt}) do
    case String.split(hgt, ~r{[0-9]+}, include_captures: true) do
      [_, num, "cm"] ->
        if String.to_integer(num) >= 150 and String.to_integer(num) <= 193, do: true, else: false

      [_, num, "in"] ->
        if String.to_integer(num) >= 59 and String.to_integer(num) <= 76, do: true, else: false

      _ ->
        false
    end
  end

  defp validate_hgt(false, _params), do: false

  defp validate_hcl(true, %{"hcl" => hcl}) do
    String.match?(hcl, ~r/^#[0-9a-f]{6}$/)
  end

  defp validate_hcl(false, _params), do: false

  defp validate_ecl(true, %{"ecl" => ecl}) do
    ecl in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
  end

  defp validate_ecl(false, _params), do: false

  defp validate_pid(true, %{"pid" => pid}) do
    String.match?(pid, ~r/^[0-9]{9}$/)
  end

  defp validate_pid(false, _params), do: false
end
