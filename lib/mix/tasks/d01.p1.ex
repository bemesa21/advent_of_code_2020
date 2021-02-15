defmodule Mix.Tasks.D01.P1 do
  use Mix.Task

  @shortdoc "Day 01 Part 1"
  def run(args) do
    input = AdventOfCode.Input.get!(1, 2020)

    if Enum.member?(args, "-b"),
      do:
        Benchee.run(%{
          part_1: fn ->
            input |> AdventOfCode.Utils.to_list(:integer) |> AdventOfCode.Day01.part1()
          end
        }),
      else:
        input
        |> AdventOfCode.Utils.to_list(:integer)
        |> AdventOfCode.Day01.part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
