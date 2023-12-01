defmodule AdventOfCode.Day01 do
  @string_integers [
    {"one", 1},
    {"two", 2},
    {"three", 3},
    {"four", 4},
    {"five", 5},
    {"six", 6},
    {"seven", 7},
    {"eight", 8},
    {"nine", 9}
  ]

  defp is_integer?(str) do
    case Integer.parse(str) do
      {_, _rest} -> true
      :error -> false
    end
  end

  defp is_integer_letter?(strs) do
    Enum.find_value(@string_integers, fn {key, val} ->
      if String.contains?(strs, key), do: {:ok, val}
    end)
  end

  defp find_first_integer(strs) do
    Enum.find(strs, fn str ->
      is_integer?(str)
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

  defp find_first([h | t], acc) do
    case is_integer?(h) do
      true ->
        String.to_integer(h)

      false ->
        case is_integer_letter?(acc <> h) do
          {:ok, val} -> val
          nil -> find_first(t, acc <> h)
        end
    end
  end

  defp find_last([h | t], acc) do
    case is_integer?(h) do
      true ->
        String.to_integer(h)

      false ->
        case is_integer_letter?(h <> acc) do
          {:ok, val} -> val
          nil -> find_last(t, h <> acc)
        end
    end
  end

  def part2(input) do
    input
    |> String.split(~r{\n}, trim: true)
    |> Enum.reduce(0, fn strs, acc ->
      first =
        String.split(strs, "", trim: true)
        |> find_first("")

      last =
        String.split(strs, "", trim: true)
        |> Enum.reverse()
        |> find_last("")

      acc + Integer.undigits([first, last])
    end)
  end
end
