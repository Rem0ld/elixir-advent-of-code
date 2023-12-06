defmodule AdventOfCode.Day05 do
  alias AdventOfCode.Tasks

  defp to_integer(list) do
    Enum.map(list, fn el -> String.to_integer(el) end)
  end

  defp get_ranges({seed, [h | t]}, acc) do
    [_, part2] = String.split(h, ~r{\:}, trim: true)

    result =
      String.split(part2, ~r{\n}, trim: true)
      |> Enum.map(fn el ->
        [dest, source, len] =
          String.split(el)
          |> to_integer()

        length =
          case len do
            val when val <= 1 -> 1
            _ -> len - 1
          end

        {dest..(dest + length), source..(source + length)}
      end)

    get_ranges({seed, t}, [result] ++ acc)
  end

  defp get_ranges({map, []}, acc), do: {map, Enum.reverse(acc)}

  defp get_seeds([h | t]) do
    [_, list] = String.split(h, ~r{\:}, trim: true)

    {String.split(list) |> to_integer(), t}
  end

  def part1(input) do
    {seeds, list} =
      String.split(input, ~r{\n\n})
      |> get_seeds()
      |> get_ranges([])

    seeds
    |> Enum.reduce(:infinity, fn seed, acc ->
      result =
        Tasks.find_destination(seed, list)

      case result < acc do
        true -> result
        _ -> acc
      end
    end)
  end

  defp to_part_two({seeds, list}) do
    result =
      Enum.chunk_every(seeds, 2)
      |> Enum.reduce([], fn [s, len], acc ->
        l =
          case len do
            val when val <= 1 -> 1
            _ -> len - 1
          end

        [s..(s + l)] ++ acc
      end)
      |> Enum.reverse()

    {result, list}
  end

  defp with_tasks(seeds, list) do
    tasks =
      Enum.map(seeds, fn range ->
        Task.async(fn -> Tasks.compute(range, list) end)
      end)

    Task.await_many(tasks, :infinity)
    |> Enum.min()
  end

  def part2(input) do
    {seeds, list} =
      String.split(input, ~r{\n\n})
      |> get_seeds()
      |> to_part_two()
      |> get_ranges([])

    with_tasks(seeds, list)
  end
end
