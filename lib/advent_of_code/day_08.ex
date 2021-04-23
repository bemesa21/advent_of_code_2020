defmodule AdventOfCode.Day08 do
  alias AdventOfCode.Utils.Day08.ExecutionValues

  def part1(input) do
    instructions = format_input(input)
    initial_values = _initial_values(instructions[0])
    {:incorrect, accumulator} = process_program(instructions, initial_values)

    accumulator
  end

  def part2(input) do
    input
    |> format_input()
    |> fix_file()
  end

  defp _initial_values(instruction) do
    %ExecutionValues{
      counter: 0,
      accumulator: 0,
      instruction: instruction
    }
  end

  defp fix_file(instructions) do
    Enum.reduce_while(instructions, instructions, fn
      {_index, %{op_code: "acc"}}, instr ->
        {:cont, instr}

      {index, instruction}, instr ->
        {result, num} = process_modified_program(instr, instruction, index)

        if result == :incorrect, do: {:cont, instr}, else: {:halt, num}
    end)
  end

  defp process_modified_program(instructions, instruction, index) do
    new_op_code = if instruction.op_code == "nop", do: "jmp", else: "nop"
    modified_instructions =
      Map.put(instructions, index, %{instruction | op_code: new_op_code})

    initial_process_values = _initial_values(modified_instructions[0])

    process_program(modified_instructions, initial_process_values)
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
          op_code: "jmp",
          number: String.to_integer(num),
          visited?: false
        }

      "acc " <> num ->
        %{
          op_code: "acc",
          number: String.to_integer(num),
          visited?: false
        }

      "nop " <> num ->
        %{
          op_code: "nop",
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

  defp process_instruction(instructions, %{op_code: "acc", number: number}, execution_values) do
    %ExecutionValues{
      counter: execution_values.counter + 1,
      accumulator: execution_values.accumulator + number,
      instruction: instructions[execution_values.counter + 1]
    }
  end

  defp process_instruction(instructions, %{op_code: "jmp", number: number}, execution_values) do
    %ExecutionValues{
      counter: execution_values.counter + number,
      accumulator: execution_values.accumulator,
      instruction: instructions[execution_values.counter + number]
    }
  end

  defp process_instruction(instructions, %{op_code: "nop"}, execution_values) do
    %ExecutionValues{
      counter: execution_values.counter + 1,
      accumulator: execution_values.accumulator,
      instruction: instructions[execution_values.counter + 1]
    }
  end
end
