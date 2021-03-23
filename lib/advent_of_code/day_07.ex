defmodule AdventOfCode.Day07 do
  def part1(args) do
    args
    |> format_rules()
    |> find_all_shiny_bags()
  end

  def part2(args) do
    rules = format_rules(args)
    sg_content = rules["shiny gold"]
    count_inner_bags(sg_content, rules)
  end

  def format_rules(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, &Map.merge(AdventOfCode.Day07.format_bag(&1), &2))
    |> IO.inspect()
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

  def format_content(<<number::binary-size(1)>> <> color, content) do
    trimmed_color = String.trim(color)
    Map.put(content, trimmed_color, String.to_integer(number))
  end

  def find_all_shiny_bags(rules) do
    Enum.reduce(rules, 0, fn {color, child_bags}, sum ->
      result = find_shiny_gold(child_bags, rules) > 0
      if result, do: sum + 1, else: sum
    end)
  end

  def find_shiny_gold(%{"shiny gold" => _}, rules), do: 1

  def find_shiny_gold(inner_bags, rules) do
    Enum.reduce(inner_bags, 0, fn {color, _number}, acc ->
      inner_bag_bags = rules[color]
      acc + find_shiny_gold(inner_bag_bags, rules)
    end)
  end

  def find_shiny_gold(%{}, rules), do: 0

  def count_inner_bags(inner_bags, rules) do
    Enum.reduce(inner_bags, 0, fn {color, number}, acc ->
      some = rules[color]
      result = count_inner_bags(some, rules)
      acc + number + number * result
    end)
  end

  def count_inner_bags(%{}, rules), do: 0
end
