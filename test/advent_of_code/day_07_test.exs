defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  alias AdventOfCode.Day07

  @tag :skip
  test "part1" do
    input = nil
    result = Day07.part1(input)

    assert result
  end

  @tag :skip
  test "part2" do
    input = nil
    result = Day07.part2(input)

    assert result
  end

  @tag :skip
  test "format a bag with many types of bag inside" do
    bag = "clear tan bags contain 5 bright purple bags, 1 pale black bag, 5 muted lime bags."
    assert Day07.format_bag(bag) ==     %{
        "clear tan" => %{
            "bright purple" => 5,
            "pale black" => 1,
            "muted lime" => 5
        }
    }
  end

  @tag :skip
  test "format a bag with just one type of bag inside" do
    bag = "mirrored silver bags contain 4 wavy gray bags"
    assert Day07.format_bag(bag) ==     %{
        "mirrored silver" => %{
            "wavy gray" => 4
        }
    }
  end

  test "format a bag with no content" do
    bag = "dim tan bags contain no other bags"
    assert Day07.format_bag(bag) ==     %{
        "dim tan" => %{}
    }
  end
end
