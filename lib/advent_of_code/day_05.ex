defmodule AdventOfCode.Day05 do
  def part1(input) do
    rows = Enum.to_list(0..127)
    columns = Enum.to_list(0..7)

    input
    |> format_input()
    |> Enum.map(&find_id(&1, rows, columns))
    |> Enum.max()
  end

  def part2(input) do
    rows = Enum.to_list(0..127)
    columns = Enum.to_list(0..7)

    input
    |> format_input()
    |> Enum.map(&find_id(&1, rows, columns))
    |> Enum.sort()
    |> find_missing_number()
  end

  def format_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&split_letters(&1))
  end

  @doc """
  Split a string of type "BFFFBBFRRR" into a tuple with
  the first 7 letters, and the last letters

  ## Examples

      iex> split_letters("BFFFBBFRRR")
        {"BFFFBBF", "RRR"}

  """
  def split_letters(<<r_letters::binary-size(7)>> <> c_letters) do
    {r_letters, c_letters}
  end

  def find_id({r_letters, c_letters}, rows, columns) do
    [x] = find_position(r_letters, rows)
    [y] = find_position(c_letters, columns)
    x * 8 + y
  end

  def find_position(letters, positions) do
    letters
    |> String.codepoints()
    |> Enum.reduce(positions, &reduce_range(&1, &2))
  end

  def reduce_range(letter, initial_range) when letter == "F" or letter == "L" do
    {lower_part, _upper} = Enum.split(initial_range, div(length(initial_range), 2))
    lower_part
  end

  def reduce_range(letter, initial_range) when letter == "B" or letter == "R" do
    {_lower, upper_part} = Enum.split(initial_range, div(length(initial_range), 2))
    upper_part
  end

  def find_missing_number([hd | tail]) do
    next = hd(tail)

    if next == hd + 1 do
      find_missing_number(tail)
    else
      hd + 1
    end
  end
end
