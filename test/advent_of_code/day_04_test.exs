defmodule AdventOfCode.Day04Test do
  use ExUnit.Case

  import AdventOfCode.Day04

  test "part1" do
    input = "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm\n\n
    iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884\nhcl:#cfa07d byr:1929\n\n
    hcl:#ae17e1 iyr:2013\neyr:2024\necl:brn pid:760753108 byr:1931\nhgt:179cm\n\n
    hcl:#cfa07d eyr:2025 pid:166559648\niyr:2011 ecl:brn hgt:59in\n"

    result = part1(input)
    assert result == 2
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
