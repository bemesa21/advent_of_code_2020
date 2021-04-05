defmodule AdventOfCode.Day09Test do
  use ExUnit.Case

  alias AdventOfCode.Day09

  @tag :skip
  test "part1" do
    input = nil
    result = Day09.part1(input)

    assert result
  end

  @tag :skip
  test "part2" do
    input = nil
    result = Day09.part2(input)

    assert result
  end

  test "format_input/1 should return a list of numbers" do
    input = "35\n30\n"
    formatted_input = Day09.format_input(input)
    assert is_list(formatted_input)
    assert length(formatted_input) == 2
    assert formatted_input == [35, 30]
  end


  test "return true if the first element of a list of integers plus another number of the list add to n " do
    n = 6
    numbers = [1,2,3,4,5]
    result = Day09.add_to?(numbers, n) 
    assert result == true
  end

  test "return false if the first element of a list of integers plus each of the rest of the numbers doesn't add to n" do
    n = 10
    numbers = [1,2,3,4,5]
    result = Day09.add_to?(numbers, n) 
    assert result == false
  end
end
