defmodule AdventOfCode.Day09 do
  def part1(args) do
  end

  def part2(args) do
  end

  def format_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def add_to?([hd | tail] = _numbers, n) do 
    Enum.reduce_while(tail, false, fn x, acc ->
      if hd + x != n, do: {:cont, false}, else: {:halt, true}
    end)
  end

  def are_two_numbers_add_up_to_n?([hd | []], n), do: false

  def are_two_numbers_add_up_to_n?([_hd | tail] = numbers, n) do
    if add_to?(numbers, n) do 
      true
    else
      add_to?(tail, n)
    end
  end

  def get_last_25_numbers(numbers, position) do
    if position < 25 do
      {first, _ } = Enum.split(numbers,position)
      first
    else 
      Enum.slice(numbers, position - 25, 25)
    end
  end
end
