defmodule AdventOfCode.Day06 do
  alias AdventOfCode.Tasks

  defp parse_input(input) do
    [l1, l2] =
      String.split(input, ~r{\n}, trim: true)
      |> Enum.map(fn line ->
        [_, nums] = String.split(line, ~r{\:}, trim: true)

        String.split(nums)
        |> Tasks.to_integer()
      end)

    Enum.zip(l1, l2)
  end

  # S = T * n 
  # D = S * ( T - n )
  defp get_combinations({time, max}) do
    result =
      Enum.map(1..time, fn n ->
        n * (time - n)
      end)
      |> Enum.filter(fn el -> el > max end)

    length(result)
  end

  defp parse_input_p2(input) do
    [l1, l2] =
      String.split(input, ~r{\n}, trim: true)
      |> Enum.map(fn line ->
        [_, nums] = String.split(line, ~r{\:}, trim: true)

        String.split(nums)
        |> Enum.join()
        |> String.to_integer()
      end)

    {l1, l2}
  end

  def part1(input) do
    parse_input(input)
    |> Enum.map(fn el -> get_combinations(el) end)
    |> Enum.product()
  end

  def part2(input) do
    parse_input_p2(input)
    |> IO.inspect(charlists: :to_lists)
    |> get_combinations()
  end
end
