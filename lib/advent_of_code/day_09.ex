defmodule AdventOfCode.Day09 do
  def part1(input, preamble, n) do
    input
    |> format_input()
    |> find_the_wrong_number(preamble, n)
  end

  def part2(input, preamble, n) do
    formatted_input = format_input(input)
    num = find_the_wrong_number(formatted_input, preamble, n)
    result = search_contiguous_numbers(formatted_input, num)
    Enum.min(result) + Enum.max(result)
  end

  def format_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def add_to?([hd | tail] = _numbers, n) do
    Enum.reduce_while(tail, false, fn x, _acc ->
      if hd + x != n, do: {:cont, false}, else: {:halt, true}
    end)
  end

  def are_two_numbers_add_up_to_n?([], _n), do: false

  def are_two_numbers_add_up_to_n?([_hd | []], _n), do: false

  def are_two_numbers_add_up_to_n?([_hd | tail] = numbers, n) do
    add_to?(numbers, n) || are_two_numbers_add_up_to_n?(tail, n)
  end

  def get_last_n_numbers(numbers, position, n) do
    {initial_index, final_index} = if position < n, do: {0, position}, else: {position - n, n}
    Enum.slice(numbers, initial_index, final_index)
  end

  def find_the_wrong_number(numbers, preamble, n) do
    positions = preamble..(length(numbers) - 1)
    first_number = Enum.at(numbers, preamble)

    Enum.reduce_while(positions, first_number, fn x, acc ->
      last_25 = get_last_n_numbers(numbers, x, n)
      num = Enum.at(numbers, x)

      if are_two_numbers_add_up_to_n?(last_25, num) do
        {:cont, false}
      else
        {:halt, num}
      end
    end)
  end

  def contiguous_sum([], {acc, num}), do: false

  def contiguous_sum([hd | tail], {acc, num}) do
    sum = Enum.sum(acc) + hd

    cond do
      sum > num -> false
      sum < num -> contiguous_sum(tail, {[hd | acc], num})
      sum == num -> [hd | acc]
    end
  end

  def search_contiguous_numbers([], _num), do: false

  def search_contiguous_numbers([_hd | tail] = numbers, num) do
    contiguous_sum(numbers, {[], num}) || search_contiguous_numbers(tail, num)
  end
end
