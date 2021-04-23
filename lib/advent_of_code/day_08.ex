defmodule AdventOfCode.Day08 do
  def part1(input) do
    {:incorrect, accumulator} =
    input
    |> format_input()
    |> process_program(0, 0)
    accumulator
  end

  def part2(input) do
    input
    |> format_input()
    |> fix_file()
  end

  def fix_file(instructions) do
    Enum.reduce_while(instructions, instructions, fn({index, instruction}, accumulator) ->
      if instruction.instruction == "jmp" or instruction.instruction == "nop" do
        modified_instruction =
        if instruction.instruction == "nop" do
          modified_instruction = Map.put(accumulator, index, %{instruction | instruction: "jmp"})
        else 
          modified_instruction = Map.put(accumulator, index, %{instruction | instruction: "nop"})
        end
        {result, num} = process_program(modified_instruction, 0,0)
        if result == :incorrect do
          {:cont, accumulator}
        else
          {:halt, num}
        end
      else
        {:cont, accumulator}
      end
    end)
  
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

      "nop " <> num ->
        %{
          instruction: "nop",
          visited?: false,
          number: String.to_integer(num)
        }
    end
  end

  def process_program(instructions, counter, accumulator) do
    instruction = instructions[counter]

    if(is_nil(instruction) or instruction.visited?) do
      if(is_nil(instruction)) do 
        {:correct, accumulator}

      else
        {:incorrect, accumulator}
      end
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
