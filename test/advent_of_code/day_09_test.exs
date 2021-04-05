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

  test "return true if two of the elements of a list of integers add to n" do 
    n = 7
    numbers = [1,2,3,4,5]
    result = Day09.are_two_numbers_add_up_to_n?(numbers, n) 
    assert result == true
  
  end

  test "return false if none two elements of a list of integers add to n" do 
    n = 100
    numbers = [1,2,3,4,5]
    result = Day09.are_two_numbers_add_up_to_n?(numbers, n) 
    assert result == false
  end

  test "given a list of numbers and an existent position n < 25, should return numbers from pos 0 to n-1" do 
    pos = 8
    numbers = [1,2,3,4,5,6,7,8,9,10]
    result = Day09.get_last_25_numbers(numbers, pos) 
    assert result == [1,2,3,4,5,6,7,8]
  end
  

  test "given a list of numbers and a position=25, should return the fisrt 25 numbers" do 
    pos = 25
    numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27]
    result = Day09.get_last_25_numbers(numbers, pos) 
    assert length(result) == 25
    assert result == [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]
  end
  
  test "given a list with length x >= 25 and a position > 25, should return the numbers in range n-25 - n-1" do
    pos = 27
    numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28]
    result = Day09.get_last_25_numbers(numbers, pos) 
    assert length(result) == 25
    assert result == [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27]
  end 
end
