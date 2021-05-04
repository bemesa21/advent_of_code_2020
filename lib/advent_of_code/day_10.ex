defmodule AdventOfCode.Day10 do
  def part1(input) do
    differences =
      input
      |> format_input()
      |> Enum.sort()
      # |> IO.inspect(label: :input)
      |> construct_adapter()
      # |> IO.inspect(label: :adapter)
      |> find_differences()
      # |> IO.inspect(label: :differences)
      |> group_differences()

    differences[1] * differences[3]
  end

  def part2(input) do
    formatted_input = format_input(input)
    max_jolt = Enum.max(formatted_input)
    tree = construct_tree(formatted_input) |> IO.inspect(charlists: :as_lists)
    valid_adapters = Enum.filter(formatted_input, &is_valid_difference?(0, &1))
    construct_adapters(tree, valid_adapters, max_jolt, 0)
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
    (num2 - num1) in 1..3
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
    # Enum.reduce(valid_options, [], fn x, acc ->
    #  [{x, Enum.reject(valid_options, fn y -> x == y end)} | acc]
    # end)
  end

  def construct_adapters(_tree, [], num, current) when current == num, do: [[current]]

  def construct_adapters(_tree, [], _num, _current), do: false

  def construct_adapters(tree, adapters, num, current_adapter) do
    Enum.reduce(adapters, [], fn x, acc ->
      result = construct_adapters(tree, tree[x], num, x)

      if result == false or result == [] do
        acc
      else
        result =
          Enum.map(result, fn x ->
            [current_adapter | x]
          end)

        result ++ acc
      end
    end)
  end

  def construct_tree(jolts) do
    Enum.reduce(jolts, %{}, fn j, acc ->
      valid_options = Enum.filter(jolts, &is_valid_difference?(j, &1))
      Map.put_new(acc, j, valid_options)
    end)
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
