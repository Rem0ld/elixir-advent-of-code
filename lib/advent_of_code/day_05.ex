defmodule AdventOfCode.Day05 do
  defp to_integer(list) do
    Enum.map(list, fn el -> String.to_integer(el) end)
  end

  defp get_ranges({map, [h | t]}) do
    [part1, part2] = String.split(h, ~r{\:}, trim: true)
    [name, _] = String.split(part1)
    IO.inspect(name, label: "name")

    String.split(part2, ~r{\n}, trim: true)
    |> IO.inspect()
    |> Enum.map(fn el ->
      [dest, source, len] =
        String.split(el)
        |> to_integer()

      {dest..(dest + len - 1), source..(source + len - 1)}
    end)
    |> IO.inspect(charlists: :as_lists)
  end

  defp get_seeds([h | t]) do
    [name, list] = String.split(h, ~r{\:}, trim: true)

    {%{name => String.split(list) |> to_integer()}, t}
  end

  def part1(input) do
    String.split(input, ~r{\n\n})
    |> get_seeds()
    |> IO.inspect()
    |> get_ranges()
  end

  def part2(_args) do
  end
end
