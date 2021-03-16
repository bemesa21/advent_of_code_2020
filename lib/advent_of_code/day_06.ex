defmodule AdventOfCode.Day06 do
  def part1(args) do
    args
    |> answers_by_groups()
    |> Stream.map(&find_questions_ocurrences(&1))
    |> Stream.map(&count_anyone_answer_yes(&1))
    |> Enum.to_list()
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> answers_by_groups()
    |> Enum.map(&find_questions_ocurrences(&1))
    |> Enum.map(&count_everyone_answer_yes(&1))
    |> Enum.sum()
  end

  def answers_by_groups(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&get_person_count_and_answers(&1))
  end

  def get_person_count_and_answers(group_answers) do
    group_answers
    |> String.split("\n", trim: true)
    |> Enum.reduce({0, ""}, fn answers, {counter, acc_answers} ->
      {counter + 1, "#{acc_answers}#{answers}"}
    end)
  end

  def find_questions_ocurrences({persons, answers}) do
    ocurrences =
      answers
      |> String.graphemes()
      |> Enum.reduce(%{}, fn char, acc ->
        Map.put(acc, char, (acc[char] || 0) + 1)
      end)

    {persons, ocurrences}
  end

  def count_anyone_answer_yes({_persons, ocurrences}) do
    Enum.reduce(ocurrences, 0, fn {_letter, _number}, acc -> acc + 1 end)
  end

  def count_everyone_answer_yes({persons, ocurrences}) do
    Enum.reduce(ocurrences, 0, fn {_letter, number}, acc ->
      if number == persons, do: acc + 1, else: acc
    end)
  end
end
