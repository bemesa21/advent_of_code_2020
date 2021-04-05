defmodule AdventOfCode.Day09 do
  def part1(args, preamble) do
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

  def are_two_numbers_add_up_to_n?([], n), do: false

  def are_two_numbers_add_up_to_n?([hd | []], n), do: false

  def are_two_numbers_add_up_to_n?([_hd | tail] = numbers, n) do
    if add_to?(numbers, n) do 
      true
    else
      are_two_numbers_add_up_to_n?(tail, n)
    end
  end

  def get_last_n_numbers(numbers, position, n) do
    if position < n do
      {first, _ } = Enum.split(numbers,position)
      first
    else 
      Enum.slice(numbers, position - n, n)
    end
  end

  def find_the_wrong_number(numbers, preamble, n) do
    positions = preamble .. length(numbers) - 2
    first_number = Enum.at(numbers, preamble) 
    Enum.reduce_while(positions, first_number, fn x, acc ->
      last_25 = get_last_n_numbers(numbers, x - 1, n)
      if are_two_numbers_add_up_to_n?(last_25, acc) do
         {:cont, Enum.at(numbers, x)}
      else
         {:halt, Enum.at(numbers, x)}
      end
    end)
  
  end
end
