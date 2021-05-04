defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  alias AdventOfCode.Day02

  test "part1" do
    result =
      ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]
      |> Enum.map(&AdventOfCode.Utils.format_params(&1))
      |> Day02.part1()

    assert result == 2
  end

  test "part2" do
    result =
      ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]
      |> Enum.map(&AdventOfCode.Utils.format_params(&1))
      |> Day02.part2()

    assert result == 1
  end
end
