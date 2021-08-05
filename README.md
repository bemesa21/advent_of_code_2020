# Advent of Code 2020 solutions

These are my solutions for the AoC 2020 exercises using Elixir 👌
I used the elixir [starter template](https://github.com/mhanberg/advent-of-code-elixir-starter) to organize the code 

## Usage

There are 25 modules, 25 tests, and 50 mix tasks.

To resolve your own input_test with my solutions, you have to create 
a `secret.exs` into `/config/`

The content should be something like this:

```elixir
use Mix.Config

config :advent_of_code, AdventOfCode.Input,
  allow_network?: true,
  session_cookie:
    "your own cookie ----------very-------large-------code"

```
After that, run 
```elixir
mix d0[n].p[m]
```

- n is the exercise number and
- m is the part (1 or 2)
