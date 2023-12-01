defmodule AdventOfCode.Day01 do
  defp find_first_integer(strs) do
    Enum.find(strs, fn str ->
      case Integer.parse(str) do
        {_, _rest} -> true
        :error -> false
      end
    end)
  end

  defp parse_int(nil, _), do: 0
  defp parse_int(_, nil), do: 0

  defp parse_int(first, last) do
    {int, _} = Integer.parse(first <> last)
    int
  end

  def part1(input) do
    input
    |> String.split(~r{\n})
    |> Enum.reduce(0, fn strs, acc ->
      first =
        String.split(strs, "")
        |> find_first_integer()

      last =
        String.split(strs, "")
        |> Enum.reverse()
        |> find_first_integer()

      int = parse_int(first, last)

      acc + int
    end)
  end

  def part2(_args) do
  end
end
