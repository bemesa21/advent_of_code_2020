defmodule AdventOfCode.Day11 do
  @positions [
    {-1, -1},
    {-1, 0},
    {-1, 1},
    {0, -1},
    {0, 1},
    {1, -1},
    {1, 0},
    {1, 1}
  ]
  def part1(input) do
    result =
    input
    |> format_input()
    |> find_the_best_position()
    |> seats_list()
    |> group_seats()

    result["#"]
  end

  def part2(args) do
  end

  def format_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, &construct_multi_map/2)
  end

  defp construct_multi_map({line, index}, acc) do
    result =
      line
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.reduce(%{}, &to_map/2)

    to_map({result, index}, acc)
  end

  defp to_map({value, index}, acc) do
    Map.put_new(acc, index, value)
  end

  def dimensions(map) do
    x = map |> Map.keys() |> Enum.max()
    y = map[0] |> Map.keys() |> Enum.max()
    {x, y}
  end

  def get_adjacencies(seats, current_position) do
    seats
    |> get_adjacent_seats(current_position)
    |> group_seats()
  end

  defp get_adjacent_seats(seats, {x, y}) do
    @positions
    |> Enum.reduce([], fn {dif_x, dif_y}, acc ->
      [seats[x + dif_x][y + dif_y] | acc]
    end)
    |> Enum.filter(& &1)
  end

  defp group_seats(adjacent_seats) do
    adjacent_seats
    |> Enum.reduce(%{}, fn x, acc ->
      Map.update(acc, x, 1, &(&1 + 1))
    end)
  end

  def apply_rules(seats) do
    Enum.reduce(seats, seats, fn {x, values}, acc ->
      Enum.reduce(values, acc, fn {y, seat}, acc2 ->
        adjacent_seats = get_adjacencies(seats, {x, y})
        put_in(acc2[x][y], apply_rule(seat, adjacent_seats))
      end)
    end)
  end

  def apply_rule("L", %{"#" => _}), do: "L"
  def apply_rule("L", _), do: "#"

  def apply_rule("#", %{"#" => num}) when num >= 4, do: "L"
  def apply_rule("#", _), do: "#"

  def apply_rule(other, _), do: other

  def to_string(seats) do
    Enum.reduce(seats, "", fn {_key, x}, acc ->
      r = Enum.map_join(x, fn {_key, value} -> value end)
      "#{acc}#{r}\n"
    end)
  end

  def find_the_best_position(seats) do
    result = apply_rules(seats)
    if seats == result do
      result
    else
      find_the_best_position(result)
    end
  end

  defp seats_list(seats) do
    Enum.reduce(seats, [], fn {_k1,v1}, acc1 ->
      Enum.reduce(v1, acc1, fn {_k2, value}, acc2 ->
        [value | acc2]
      end)
    end)
  end
end
