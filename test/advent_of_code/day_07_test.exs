defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  alias AdventOfCode.Day07
  @example_input "light red bags contain 1 bright white bag, 2 muted yellow bags.\n
  dark orange bags contain 3 bright white bags, 4 muted yellow bags.\n
  bright white bags contain 1 shiny gold bag.\n
  muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.\n
  shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.\n
  dark olive bags contain 3 faded blue bags, 4 dotted black bags.\n
  vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.\n
  faded blue bags contain no other bags.\n
  dotted black bags contain no other bags.\n"

  test "part1" do
    assert Day07.part1(@example_input) == 4
  end

  test "part2" do
    assert Day07.part2(@example_input) == 32
  end

  test "format a bag with many types of bag inside" do
    bag = "clear tan bags contain 5 bright purple bags, 1 pale black bag, 5 muted lime bags."

    assert Day07.format_bag(bag) == %{
             "clear tan" => %{
               "bright purple" => 5,
               "pale black" => 1,
               "muted lime" => 5
             }
           }
  end

  test "format a bag with just one type of bag inside" do
    bag = "mirrored silver bags contain 4 wavy gray bags"

    assert Day07.format_bag(bag) == %{
             "mirrored silver" => %{
               "wavy gray" => 4
             }
           }
  end

  test "format a bag with no content" do
    bag = "dim tan bags contain no other bags"

    assert Day07.format_bag(bag) == %{
             "dim tan" => %{}
           }
  end
end
