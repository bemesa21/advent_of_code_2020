defmodule AdventOfCode.Utils do
  def to_list(input, :integer) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer(&1))
  end

  def format_input(string, :two) do
    string
    |> string_to_list
    |> Enum.map(&format_params(&1))
  end

  def format_params(string) do
    result = String.split(string, ["-", ": ", " "])
    {Enum.at(result, 0), Enum.at(result, 1), Enum.at(result, 2), Enum.at(result, 3)}
  end

  defp string_to_list(string) do
    String.split(string, "\n", trim: true)
  end
end
