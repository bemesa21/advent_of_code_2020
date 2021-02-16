defmodule Mix.Tasks.D02.P1 do
  use Mix.Task

  alias AdventOfCode.Day02

  @shortdoc "Day 02 Part 1"
  def run(args) do
    input = AdventOfCode.Input.get!(2, 2020)

    if Enum.member?(args, "-b"),
      do:
        Benchee.run(%{
          part_2: fn -> input |> AdventOfCode.Utils.format_input(:two) |> Day02.part1() end
        }),
      else:
        some =
          input
          |> AdventOfCode.Utils.format_input(:two)
          |> Day02.part1()
          |> IO.inspect(label: "Part 2 Results")
  end
end
