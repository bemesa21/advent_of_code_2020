defmodule AdventOfCode.Day08 do
  def part1(input) do
    input
    |> format_input()
    |> IO.inspect(label: :formatted_input)
    |> process_program(0, 0)
  end

  def part2(args) do
  end

  def format_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {instruction, index}, acc ->
      formatted_instruction = format_instruction(instruction)
      Map.put(acc, index, formatted_instruction)
    end)
  end

  def format_instruction(instruction) do
    case instruction do
      "jmp " <> num ->
        %{
          instruction: "jmp",
          number: String.to_integer(num),
          visited?: false
        }

      "acc " <> num ->
        %{
          instruction: "acc",
          number: String.to_integer(num),
          visited?: false
        }

      _ ->
        %{
          instruction: "nop",
          visited?: false
        }
    end
  end

  def process_program(instructions, counter, accumulator) do
    instruction = instructions[counter]

    if(is_nil(instruction) or instruction.visited?) do
      accumulator
    else
      case instruction do
        %{instruction: "acc", number: number} ->
          instructions = Map.put(instructions, counter, %{instruction | visited?: true})
          process_program(instructions, counter + 1, accumulator + number)

        %{instruction: "jmp", number: number} ->
          instructions = Map.put(instructions, counter, %{instruction | visited?: true})
          process_program(instructions, counter + number, accumulator)

        %{instruction: "nop"} ->
          instructions = Map.put(instructions, counter, %{instruction | visited?: true})
          process_program(instructions, counter + 1, accumulator)
      end
    end
  end
end
