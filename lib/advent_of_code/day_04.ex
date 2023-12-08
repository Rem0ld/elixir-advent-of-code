defmodule AdventOfCode.Day04 do
  defp to_working_list(input) do
    input
    |> String.split(~r{\n}, trim: true)
    |> Enum.map(fn line ->
      [h, t] = String.split(line, ~r{\:}, trim: true)
      [_, game_number] = String.split(h)
      [h, t] = String.split(t, ~r{\|})

      {
        String.to_integer(game_number),
        String.split(h)
        |> Enum.reduce(%{}, fn el, acc ->
          case Integer.parse(el) do
            {val, _} -> Map.put(acc, val, true)
            :error -> acc
          end
        end),
        String.split(t)
        |> Enum.map(fn el -> String.to_integer(el) end)
      }
    end)
  end

  def part1(input) do
    to_working_list(input)
    |> Enum.reduce(0, fn {_, map, list}, acc ->
      result =
        Enum.reduce(list, 0, fn el, acc ->
          case Map.has_key?(map, el) do
            true when acc === 0 -> acc + 1
            true -> acc * 2
            false -> acc
          end
        end)

      acc + result
    end)
  end

  defp get_winnings(map, list) do
    Enum.reduce(list, 0, fn el, acc ->
      case Map.has_key?(map, el) do
        true -> acc + 1
        false -> acc
      end
    end)
  end

  def part2(input) do
    to_working_list(input)
    |> Enum.reduce(%{}, fn {game_num, keys, values}, acc ->
      Map.put(acc, game_num, {get_winnings(keys, values), 1})
    end)
    |> IO.inspect()
    |> Enum.reduce(%{}, fn map ->
      # w > 1 && n = copies * n 
      win =
        Stream.unfold({1, map}, fn {count, {_, {win, cop}} = inner_map} ->
          if count >= win do
            nil
          else
            new_map =
              Map.update(inner_map, count, 1, fn {inner_win, inner_cop} ->
                {inner_win, inner_cop + cop}
              end)

            {count + 1, new_map}
          end
        end)
        |> Enum.take(4)

      win
    end)
  end
end
