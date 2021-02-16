defmodule Mix.Tasks.D02.P2 do
  use Mix.Task

  alias AdventOfCode.Day02

  @shortdoc "Day 02 Part 2"
  def run(args) do
    input = AdventOfCode.Input.get!(2, 2020)

    if Enum.member?(args, "-b"),
      do:
        Benchee.run(%{part_2: fn -> input |> AdventOfCode.Utils.format_input(:two) |> Day02.part2() end}),
      else:
        input
        |> AdventOfCode.Utils.format_input(:two)
        |> Day02.part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
