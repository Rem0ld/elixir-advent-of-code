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

  def part2(_input) do
    # to_working_list(input)
    # |> IO.inspect()
    # |> Enum.reduce( %{}, 
    #   fn {game_number, winning_numbers_map, list}, {count, mul_map} = acc -> 
    #     Map.update(mul_map, game_number, 1, fn el -> 
    #       el + 1
    #     end)
    #
    #     result =
    #       Enum.reduce(list, 0, fn el, inner_acc -> 
    #         case Map.has_key?(winning_numbers_map, el)
    #       end)
    # end)
  end
end
