defmodule AdventOfCode.Day09 do
  defp parse_input(input) do
    String.split(input, ~r{\n}, trim: true)
    |> Enum.map(fn el ->
      String.split(el)
      |> Enum.map(fn char ->
        String.to_integer(char)
      end)
    end)
    |> IO.inspect(label: "Parsed")
  end

  defp process_line(line, acc) do
    rest =
      Enum.reduce(line, {[], nil}, fn el, {list, last_el} ->
        if is_nil(last_el) do
          {list, el}
        else
          {[el - last_el] ++ list, el}
        end
      end)
      |> IO.inspect(label: "rest")

    case List.first(rest) ===
           List.last(rest) do
      true -> acc
    end
  end

  def part1(input) do
    parse_input(input)
    |> Enum.each(fn line ->
      process_line(line, 0)
    end)
  end

  def part2(_args) do
  end
end
