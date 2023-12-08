defmodule AdventOfCode.Day07 do
  @points ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]

  # Lower is better
  defp compute_points() do
    @points
    |> Enum.with_index(1)
    |> Enum.reduce(%{}, fn {key, val}, acc ->
      Map.put(acc, key, val)
    end)
  end

  defp parse_input(input) do
    String.split(input, ~r{\n}, trim: true)
    |> Enum.map(fn line ->
      [hand, score] = String.split(line)
      {String.split(hand, "", trim: true), score}
    end)
  end

  defp count_cards(hand) do
    points = compute_points()

    Enum.reduce(hand, %{}, fn el, acc ->
      Map.update(acc, points[el], 1, fn curr -> curr + 1 end)
    end)
    |> Enum.to_list()
    |> Enum.reduce({nil, []}, fn {key, val}, {score, points} = acc ->
      case val do
        2 when score === :pair ->
          {:double_pair, points ++ [key]}

        2 ->
          {:pair, points ++ [key]}

        3 when score === :pair ->
          {:full, points ++ [key]}

        3 ->
          {:brelan, points ++ [key]}

        4 ->
          {:carre, points ++ [key]}

        5 ->
          {:five, points ++ [key]}

        _ ->
          acc
      end
    end)
  end

  def part1(input) do
    result =
      parse_input(input)
      |> IO.inspect()
      |> Enum.map(fn {list, score} ->
        result =
          count_cards(list)
          |> IO.inspect(charlists: :to_lists)

        {result, score}
      end)

    # |> IO.inspect()
  end

  def part2(_args) do
  end
end
