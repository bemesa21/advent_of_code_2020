defmodule AdventOfCode.Day11Test do
  use ExUnit.Case

  alias AdventOfCode.Day11

  test "part1" do
    input = """
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
    """
    assert Day11.part1(input) == 37

  end

  @tag :skip
  test "part2" do
    input = nil
    result = Day11.part2(input)

    assert result
  end

  test "format an input with one line has to return a map with just one key" do
    input = "L.LL.LL.L\n"

    assert %{
             0 => %{
               0 => "L",
               1 => ".",
               2 => "L",
               3 => "L",
               4 => ".",
               5 => "L",
               6 => "L",
               7 => ".",
               8 => "L"
             }
           } == Day11.format_input(input)
  end

  test "dimensions/1 returns {0, 8}" do
    input = %{
      0 => %{
        0 => "L",
        1 => ".",
        2 => "L",
        3 => "L",
        4 => ".",
        5 => "L",
        6 => "L",
        7 => ".",
        8 => "L"
      }
    }

    assert {0, 8} == Day11.dimensions(input)
  end

  test "get_adjacencies/2 returns a map with 3#, 4L, 1." do
    input = %{
      0 => %{
        0 => "L",
        1 => "#",
        2 => "."
      },
      1 => %{
        0 => "L",
        1 => "*",
        2 => "L"
      },
      2 => %{
        0 => "#",
        1 => "L",
        2 => "#"
      }
    }

    result = Day11.get_adjacencies(input, {1, 1})
    assert result["#"] == 3
    assert result["L"] == 4
    assert result["."] == 1
  end

  test "get_adjacencies/2 in the upside frontier" do
    input = %{
      0 => %{
        0 => "L",
        1 => "#",
        2 => "."
      },
      1 => %{
        0 => "L",
        1 => "*",
        2 => "L"
      },
      2 => %{
        0 => "#",
        1 => "L",
        2 => "#"
      }
    }

    result = Day11.get_adjacencies(input, {0, 1})
    assert result["*"] == 1
    assert result["L"] == 3
    assert result["."] == 1
  end

  test "If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied #." do
    assert Day11.apply_rule("L", %{"L" => 1}) == "#"
  end

  test "If a seat is empty (L) and there occupied seats adjacent to it, the seat doesnt change" do
    assert Day11.apply_rule("L", %{"L" => 1, "#" => 1}) == "L"
  end

  test "If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty" do
    assert Day11.apply_rule("#", %{"#" => 4}) == "L"
  end

  test "If a seat is occupied (#) and four or more seats adjacent to it are also occupied, it doesnt change" do
    assert Day11.apply_rule("#", %{"L" => 1, "#" => 1}) == "#"
  end

  test "apply_rules/1 with example input, round1" do
    input = """
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
    """

    result = input |> Day11.format_input() |> Day11.apply_rules() |> Day11.to_string()

    assert result ==
             """
             #.##.##.##
             #######.##
             #.#.#..#..
             ####.##.##
             #.##.##.##
             #.#####.##
             ..#.#.....
             ##########
             #.######.#
             #.#####.##
             """
  end

  test "apply_rules/1 with example input, round2" do
    input = """
    #.##.##.##
    #######.##
    #.#.#..#..
    ####.##.##
    #.##.##.##
    #.#####.##
    ..#.#.....
    ##########
    #.######.#
    #.#####.##
    """

    result = input |> Day11.format_input() |> Day11.apply_rules() |> Day11.to_string()

    assert result ==
             """
             #.LL.L#.##
             #LLLLLL.L#
             L.L.L..L..
             #LLL.LL.L#
             #.LL.LL.LL
             #.LLLL#.##
             ..L.L.....
             #LLLLLLLL#
             #.LLLLLL.L
             #.#LLLL.##
             """
  end
end
