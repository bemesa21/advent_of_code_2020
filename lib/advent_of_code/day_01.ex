defmodule AdventOfCode.Day01 do
  @expected_value 2020

  def part1(args) do
    args
    |> search_numbers()
    |> mul_numbers()
  end

  def part2(args) do
  end

  def search_numbers([]), do: :not_found

  def search_numbers([hd | tail] = args) do
    if result = iterate_elements(hd, tail) do
      result
    else
      search_numbers(tail)
    end
  end

  defp iterate_elements(num, [num2]) when num + num2 == @expected_value, do: {num, num2}

  defp iterate_elements(num, [num2]), do: false

  defp iterate_elements(num, []), do: false

  defp iterate_elements(num, [hd | tail] = iterate_elements) do
    cond do
      hd + num == @expected_value ->
        {hd, num}

      num + List.last(tail) == @expected_value ->
        {num, List.last(tail)}

      true ->
        iterate_elements(num, Enum.drop(tail, -1))
    end
  end

  defp mul_numbers({num1, num2}), do: num1 * num2
end
