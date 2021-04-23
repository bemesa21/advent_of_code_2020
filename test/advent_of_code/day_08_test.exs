defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  alias AdventOfCode.Day08

  test "part1" do
    input = "nop +0\nacc +1\njmp +4\nacc +3\njmp -3\nacc -99\nacc +1\njmp -4\nacc +6"
    result = Day08.part1(input)
    assert result == 5
  end

  test "part2" do
    input = "nop +0\nacc +1\njmp +4\nacc +3\njmp -3\nacc -99\nacc +1\njmp -4\nacc +6"
    result = Day08.part2(input)
    assert result == 8
  end

  test "format a instruction jmp should return a map with three elements" do
    result = Day08.format_instruction("jmp -3")

    assert result == %{
             instruction: "jmp",
             number: -3,
             visited?: false
           }
  end

  test "format a instruction acc should return a map with three elements" do
    result = Day08.format_instruction("acc -3")

    assert result == %{
             instruction: "acc",
             number: -3,
             visited?: false
           }
  end

  test "format a instruction nop should return a map with three elements" do
    result = Day08.format_instruction("nop -0")

    assert result == %{
             instruction: "nop",
             visited?: false,
             number: 0
           }
  end

  test "format a string of instructions should return an indexed map" do
    result = Day08.format_input("acc -3\nnop -0 ")

    assert result ==
             %{
               0 => %{
                 instruction: "acc",
                 number: -3,
                 visited?: false
               },
               1 => %{
                 instruction: "nop",
                 visited?: false,
                 number: 0
               }
             }
  end

  test "A program with just an acc +3 instruction should return 3" do
    result =
      Day08.format_input("acc -3")
      |> Day08.process_program(0, 0)

    assert result == {:correct, -3}
  end

  test "A program with just an nop instruction should return 1" do
    result =
      Day08.format_input("nop +0")
      |> Day08.process_program(0, 0)

    assert result == {:correct, 0}
  end
end
