defmodule AdventOfCode.Day04 do
  def part1(args) do
    args
    |> format_input()
    |> Enum.map(&validate_required(&1))
    |> Enum.count(fn x -> x == true end)
  end

  def part2(args) do
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

  defp params_validations(string) do
  end
end
