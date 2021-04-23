defmodule AdventOfCode.Day08 do
  alias AdventOfCode.Utils.Day08.ExecutionValues

  def part1(input) do
    instructions = format_input(input)

    params = %ExecutionValues{
      counter: 0,
      accumulator: 0,
      instruction: instructions[0]
    }

    {:incorrect, accumulator} = process_program(instructions, params)

    accumulator
  end

  def part2(input) do
    input
    |> format_input()
    |> fix_file()
  end

  def fix_file(instructions) do
    Enum.reduce_while(instructions, instructions, fn {index, instruction}, accumulator ->
      if instruction.instruction == "jmp" or instruction.instruction == "nop" do
        modified_instruction =
          if instruction.instruction == "nop" do
            modified_instruction =
              Map.put(accumulator, index, %{instruction | instruction: "jmp"})
          else
            modified_instruction =
              Map.put(accumulator, index, %{instruction | instruction: "nop"})
          end

        params = %ExecutionValues{
          counter: 0,
          accumulator: 0,
          instruction: modified_instruction[0]
        }

        {result, num} = process_program(modified_instruction, params)

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

  def process_program(_instructions, %{instruction: instruction} = execution_values)
      when is_nil(instruction) do
    {:correct, execution_values.accumulator}
  end

  def process_program(_instructions, %{instruction: instruction} = execution_values)
      when instruction.visited? do
    {:incorrect, execution_values.accumulator}
  end

  def process_program(instructions, %{instruction: instruction} = execution_values) do
    instructions =
      Map.put(instructions, execution_values.counter, %{instruction | visited?: true})

    execution_values = process_instruction(instructions, instruction, execution_values)
    process_program(instructions, execution_values)
  end

  defp process_instruction(instructions, %{instruction: "acc", number: number}, execution_values) do
    %ExecutionValues{
      counter: execution_values.counter + 1,
      accumulator: execution_values.accumulator + number,
      instruction: instructions[execution_values.counter + 1]
    }
  end

  defp process_instruction(instructions, %{instruction: "jmp", number: number}, execution_values) do
    %ExecutionValues{
      counter: execution_values.counter + number,
      accumulator: execution_values.accumulator,
      instruction: instructions[execution_values.counter + number]
    }
  end

  defp process_instruction(instructions, %{instruction: "nop"}, execution_values) do
    %ExecutionValues{
      counter: execution_values.counter + 1,
      accumulator: execution_values.accumulator,
      instruction: instructions[execution_values.counter + 1]
    }
  end
end
