defmodule AdventOfCode.Utils do
  def to_list(input, :integer) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer(&1))
  end
end
