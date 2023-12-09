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

  defp compute_score(el, {atom, map}) do
    updated =
      Map.update(map, el, 1, fn curr -> curr + 1 end)

    result =
      case updated[el] do
        2 when atom === :pair ->
          {:double_pair}

        2 ->
          {:pair}

        3 when atom === :pair ->
          {:full}

        3 ->
          {:brelan}

        4 ->
          {:carre}

        5 ->
          {:five}

        _ ->
          {atom}
      end

    Tuple.append(result, updated)
  end

  defp count_cards({hand, bid}) do
    points = compute_points()

    hand_in_points =
      Enum.map(hand, fn el ->
        points[el]
      end)

    Enum.reduce(hand, {nil, %{}}, &compute_score/2)
    |> Tuple.delete_at(1)
    |> Tuple.append(hand_in_points)
    |> Tuple.append(bid)
    |> IO.inspect()
  end

  def part1(input) do
    parse_input(input)
    |> IO.inspect()
    |> Enum.map(&count_cards/1)
    |> Enum.reduce(%{}, fn {atom, list, bid}, acc ->
      Map.put_new(acc, atom, [])
      |> Map.update(atom, [], fn existing_value ->
        [{list, bid}] ++ existing_value
      end)
    end)
    # |> List.keysort(1)
    |> IO.inspect(charlists: :to_lists)

    # |> IO.inspect()
  end

  def part2(_args) do
  end
end
