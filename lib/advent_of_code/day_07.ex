defmodule AdventOfCode.Day07 do
  def part1(args) do
  end

  def part2(args) do
  end

  def format_bag(content) do
    [bag, content] =
    content
    |> String.replace(["bag", "bags"], "")
    |> String.split("contain")

    formatted_content =
    Regex.scan(~r/[0-9]+[a-z\s]*/, content)
    |> List.flatten()
    |> Enum.reduce(%{}, &format_content/2)

    %{String.trim(bag) => formatted_content}
  end
#iex(1)> input |> String.split("\n", trim: true) |> Enum.map(&AdventOfCode.Day07.format_bag/1)
  def format_content(<<number::binary-size(1)>> <> color, content) do
    trimmed_color = String.trim(color)
    Map.put(content, trimmed_color, String.to_integer(number))
  end
end
