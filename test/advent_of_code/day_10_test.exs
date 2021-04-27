defmodule AdventOfCode.Day10Test do
  use ExUnit.Case

  alias AdventOfCode.Day10

  test "part 1: Test tiny example input" do
    input = """
    16
    10
    15
    5
    1
    11
    7
    19
    6
    12
    4
    """

    assert Day10.part1(input) == 35
  end

  test "Part1: Test medium example input" do
    input = """
    28
    33
    18
    42
    31
    14
    46
    20
    48
    47
    24
    23
    49
    45
    19
    38
    39
    11
    1
    32
    25
    35
    8
    17
    7
    9
    4
    2
    34
    10
    3
    """

    assert Day10.part1(input) == 220
  end

  @tag :skip
  test "part2" do
    input = nil
    result = Day10.part2(input)

    assert result
  end

  test "the difference between 4 and 2 is valid" do
    assert Day10.is_valid_difference?(4, 2) == true
  end

  test "the difference between 4 and 1 is valid" do
    assert Day10.is_valid_difference?(4, 1) == true
  end

  test "the difference between 1 and 5 is invalid" do
    assert Day10.is_valid_difference?(1, 5) == false
  end

  test "differences has to be [1, 3]" do
    result =
      [1]
      |> Day10.find_differences()
      |> Enum.reverse()

    assert result == [1, 3]
  end

  test "differences for small input has to be [1, 3, 1, 1, 1, 3, 1, 1, 3, 1, 3, 3]" do
    result =
      [1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19]
      |> Day10.find_differences()
      |> Enum.reverse()

    assert result == [1, 3, 1, 1, 1, 3, 1, 1, 3, 1, 3, 3]
  end

  test "has to return a 7 difference of one and 5 differences of 5" do
    assert Day10.group_differences([1, 3, 1, 1, 1, 3, 1, 1, 3, 1, 3, 3]) == %{1 => 7, 3 => 5}
  end
end
