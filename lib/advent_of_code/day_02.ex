defmodule AdventOfCode.Day02 do
  @max_values %{blue: 14, green: 13, red: 12}

  defp get_game_number(line) do
    [h, rest] = String.split(line, ~r{\:}, trim: true)
    [_, t] = String.split(h)

    {String.to_integer(t), rest}
  end

  defp get_rounds(line) do
    String.split(line, ~r{;}, trim: true)
    |> Enum.join(",")
    |> String.split(~r{,}, trim: true)
    |> Enum.map(fn el ->
      String.split(el)
    end)
    |> Enum.reduce(%{blue: 0, green: 0, red: 0}, fn [num, color], curr_acc ->
      curr_val = curr_acc[String.to_atom(color)]

      if String.to_integer(num) > curr_val do
        %{curr_acc | String.to_atom(color) => String.to_integer(num)}
      else
        curr_acc
      end
    end)
  end

  defp is_bigger?(%{blue: b, green: g, red: r}) do
    with true <- b <= @max_values[:blue],
         true <- g <= @max_values[:green],
         true <- r <= @max_values[:red] do
      true
    else
      false -> false
    end
  end

  @spec process_line(binary()) :: {:ok, integer()} | :error
  defp process_line(line) do
    {game_number, rest} = get_game_number(line)

    result = get_rounds(rest)

    with true <- is_bigger?(result) do
      {:ok, game_number}
    else
      false -> :error
    end
  end

  def part1(input) do
    input
    |> String.split(~r{\n}, trim: true)
    |> Enum.reduce(0, fn line, acc ->
      case process_line(line) do
        {:ok, val} -> acc + val
        :error -> acc
      end
    end)
  end

  def part2(input) do
    input
    |> String.split(~r{\n}, trim: true)
    |> Enum.map(fn line ->
      {_, rest} = get_game_number(line)

      get_rounds(rest)
      |> Map.values()
      |> Enum.product()
    end)
    |> Enum.sum()
    |> IO.inspect(label: "result")
  end
end
