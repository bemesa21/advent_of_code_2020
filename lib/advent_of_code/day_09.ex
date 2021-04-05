defmodule AdventOfCode.Day09 do
  def part1(args) do
  end

  def part2(args) do
  end

  def format_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def add_to?([hd | tail] = _numbers, n) do 
    Enum.reduce_while(tail, false, fn x, acc ->
      if hd + x != n, do: {:cont, false}, else: {:halt, true}
    end)
  end


  
end
