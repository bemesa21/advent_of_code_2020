defmodule AdventOfCode.Day02 do
  def part1(params) do
    params
    |> validate_passwords
    |> count_valid_passwords
  end

  def part2(params) do
  end

  defp validate_passwords(params) do
    Enum.map(params, fn {min, max, letter, password} ->
      frequency = letter_frequency(password, letter)

      if frequency <= String.to_integer(max) and frequency >= String.to_integer(min),
        do: true,
        else: false
    end)
  end

  defp count_valid_passwords(passwords) do
    Enum.count(passwords, fn x -> x == true end)
  end

  defp letter_frequency(password, letter) do
    frequencies =
      password
      |> String.downcase()
      |> String.graphemes()
      |> Enum.frequencies()

    frequencies[letter]
  end
end
