defmodule AdventOfCode.Day09Test do
  use ExUnit.Case

  alias AdventOfCode.Day09

  test "part1: return 127" do
    input =
      "35\n20\n15\n25\n47\n40\n62\n55\n65\n95\n102\n117\n150\n182\n127\n219\n299\n277\n309\n576"

    preamble = 5
    how_many_previous = 5
    assert Day09.part1(input, preamble, how_many_previous) == 127
  end

  test "part2: return 62" do
    input =
      "35\n20\n15\n25\n47\n40\n62\n55\n65\n95\n102\n117\n150\n182\n127\n219\n299\n277\n309\n576"

    preamble = 5
    how_many_previous = 5
    assert Day09.part2(input, preamble, how_many_previous) == 62
  end

  test "format_input/1 return a list of numbers" do
    input = "35\n30\n"
    assert Day09.format_input(input) == [35, 30]
  end

  test "return true if the first element of a list of integers plus another number of the list add to n " do
    n = 6
    numbers = [1, 2, 3, 4, 5]
    assert Day09.add_to?(numbers, n) == true
  end

  test "return false if the first element of a list of integers plus each of the rest of the numbers doesn't add to n" do
    n = 10
    numbers = [1, 2, 3, 4, 5]
    assert Day09.add_to?(numbers, n) == false
  end

  test "return true if two of the elements of a list of integers add to n" do
    n = 7
    numbers = [1, 2, 3, 4, 5]
    assert Day09.are_two_numbers_add_up_to_n?(numbers, n) == true
  end

  test "return false if none two elements of a list of integers add to n" do
    n = 100
    numbers = [1, 2, 3, 4, 5]
    assert Day09.are_two_numbers_add_up_to_n?(numbers, n) == false
  end

  test "given a list of numbers and an existent position n < 25, should return numbers from pos 0 to n-1" do
    pos = 8
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    n = 25
    assert Day09.get_last_n_numbers(numbers, pos, n) == [1, 2, 3, 4, 5, 6, 7, 8]
  end

  test "given a list of numbers and a position=25, has to return the fisrt 25 numbers" do
    pos = 25

    numbers = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27
    ]

    n = 25
    result = Day09.get_last_n_numbers(numbers, pos, n)
    assert length(result) == n

    assert result == [
             1,
             2,
             3,
             4,
             5,
             6,
             7,
             8,
             9,
             10,
             11,
             12,
             13,
             14,
             15,
             16,
             17,
             18,
             19,
             20,
             21,
             22,
             23,
             24,
             25
           ]
  end

  test "given a list with length x >= 25 and a position > 25, has to return the numbers in range n-25 - n-1" do
    pos = 27

    numbers = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28
    ]

    n = 25
    result = Day09.get_last_n_numbers(numbers, pos, n)
    assert length(result) == n

    assert result == [
             3,
             4,
             5,
             6,
             7,
             8,
             9,
             10,
             11,
             12,
             13,
             14,
             15,
             16,
             17,
             18,
             19,
             20,
             21,
             22,
             23,
             24,
             25,
             26,
             27
           ]
  end

  test "return 300, it isn't the sum of two numbers in the last 25 numbers starting from 5 preamble-numbers" do
    numbers = [1, 2, 3, 4, 5, 300]
    preamble = 5
    n = 25
    assert Day09.find_the_wrong_number(numbers, preamble, n) == 300
  end

  test "returns a list with the first n contiguous numbers that add to X " do
    numbers = [2, 2, 2, 1, 5, 6]
    acc = []
    x = 7
    result = Day09.contiguous_sum(numbers, {acc, x})
    assert Enum.reverse(result) == [2, 2, 2, 1]
  end

  test "return the list of contiguous numbers that sum x, even if they are not at the start of the list" do
    numbers = [1, 1, 1, 5, 9, 1, 2, 1]
    x = 4
    result = Day09.search_contiguous_numbers(numbers, x)
    assert Enum.reverse(result) == [1, 2, 1]
  end
end
