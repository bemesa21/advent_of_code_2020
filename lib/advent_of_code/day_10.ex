defmodule AdventOfCode.Day10 do
  def part1(input) do
    differences =
      input
      |> format_input()
      |> Enum.sort()
      #|> IO.inspect(label: :input)
      |> construct_adapter()
      #|> IO.inspect(label: :adapter)
      |> find_differences()
      #|> IO.inspect(label: :differences)
      |> group_differences()

    differences[1] * differences[3]
  end

  def part2(args) do
  end

  def format_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def is_valid_difference?(num1, num2) when num1 == num2 do
    false
  end

  def is_valid_difference?(num1, num2) do
    (num1 - num2) in -3..3
  end

  def construct_adapter([add1] = _adapters), do: [add1]

  def construct_adapter([add1, add2] = _adapters) do
    if is_valid_difference?(add1, add2) do
      [add1, add2]
    else
      false
    end
  end

  def construct_adapter([hd | tail] = _adapters) do
    valid_options = Enum.filter(tail, &is_valid_difference?(hd, &1))
    posible = posible_combinations(valid_options, tail)

    result =
      Enum.reduce_while(posible, [], fn {key, [x]}, _acc ->
        result = construct_adapter([key | x])
        if result == false, do: {:cont, []}, else: {:halt, result}
      end)

    [hd | result]
  end

  def posible_combinations(valid_options, adapters) do
    Enum.group_by(valid_options, & &1, &Enum.reject(adapters, fn x -> &1 == x end))
  end

  def find_differences(jolts) do
    jolts = jolts ++ [List.last(jolts) + 3]

    {_final, differences} =
      Enum.reduce(jolts, {0, []}, fn x, {prev, acc} ->
        difference = x - prev
        {x, [difference | acc]}
      end)

    differences
  end

  def group_differences(differences) do
    Enum.reduce(differences, %{}, fn x, acc ->
      if Map.has_key?(acc, x) do
        Map.put(acc, x, acc[x] + 1)
      else
        Map.put_new(acc, x, 1)
      end
    end)
  end
end
