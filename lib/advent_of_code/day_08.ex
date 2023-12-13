defmodule AdventOfCode.Day08 do
  defp parse_input(input) do
    [path | rest] = String.split(input, ~r{\n}, trim: true)

    result =
      rest
      |> Enum.reduce(%{}, fn el, acc ->
        [key, values] =
          String.split(el, ~r{ = }, trim: true)

        [left, right] =
          String.trim(values, "(")
          |> String.trim(")")
          |> String.split(~r{, }, trim: true)

        Map.put(acc, key, {left, right})
      end)

    {String.split(path, "", trim: true), result}
  end

  defp traverse(_, _, {goal, key}, count) when goal === key, do: count

  defp traverse([h | t], map, {goal, key}, count) do
    {left, right} = Map.get(map, key)

    case h do
      "L" ->
        traverse(t ++ [h], map, {goal, left}, count + 1)

      "R" ->
        traverse(t ++ [h], map, {goal, right}, count + 1)
    end
  end

  def part1(input) do
    {path, map} =
      parse_input(input)

    traverse(path, map, {"ZZZ", "AAA"}, 0)
  end

  def part2(_args) do
  end
end
