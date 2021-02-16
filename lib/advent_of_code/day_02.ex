defmodule AdventOfCode.Day02 do
  def part1(params) do
    params
    |> validate_passwords(:one)
    |> count_valid_passwords
  end

  def part2(params) do
    params
    |> validate_passwords(:two)
    |> count_valid_passwords
  end

  defp validate_passwords(params, :one) do
    Enum.map(params, fn {min, max, letter, password} ->
      frequency = letter_frequency(password, letter)

      if frequency <= String.to_integer(max) and frequency >= String.to_integer(min),
        do: true,
        else: false
    end)
  end

  defp validate_passwords(params, :two) do
    Enum.map(params, &validate_letter_position(&1))
  end

  defp validate_letter_position({pos1, pos2, letter, password}) do
    pos1 = String.to_integer(pos1) - 1
    pos2 = String.to_integer(pos2) - 1

    cond do
      String.at(password, pos1) == letter and String.at(password, pos2) != letter ->
        true

      String.at(password, pos1) != letter and String.at(password, pos2) == letter ->
        true

      true ->
        false
    end
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
