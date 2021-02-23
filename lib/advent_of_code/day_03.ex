defmodule AdventOfCode.Day03 do
  def part1(args, width) do
    args
    |> format_input()
    |> count_trees({0, 0}, {3, 1}, width)
  end

  def part2(args, width) do
    input = format_input(args)

    [
      {1, 1},
      {3, 1},
      {5, 1},
      {7, 1},
      {1, 2}
    ]
    |> Enum.map(&count_trees(input, {0, 0}, &1, width))
    |> Enum.reduce(1, fn x, acc -> x * acc end)
  end

  defp format_input(input) do
    input |> String.split() |> Enum.map(&String.graphemes(&1))
  end

  defp count_trees([], _, _, _), do: 0

  defp count_trees([line | other], {pos_x, pos_y}, {inc_x, inc_y}, width)
       when pos_x < width and rem(pos_y, inc_y) == 0 do
    result = count_trees(other, {pos_x + inc_x, pos_y + 1}, {inc_x, inc_y}, width)
    if Enum.at(line, pos_x) == "#", do: result + 1, else: result
  end

  defp count_trees([line | other], {pos_x, pos_y}, {inc_x, inc_y}, width)
       when rem(pos_y, inc_y) == 0 do
    result = count_trees(other, {pos_x + inc_x, pos_y + 1}, {inc_x, inc_y}, width)
    if Enum.at(line, rem(pos_x, width)) == "#", do: result + 1, else: result
  end

  defp count_trees([_line | other], {pos_x, pos_y}, {inc_x, inc_y}, width) do
    count_trees(other, {pos_x, pos_y + 1}, {inc_x, inc_y}, width)
  end
end
