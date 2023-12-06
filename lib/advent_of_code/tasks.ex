defmodule AdventOfCode.Tasks do
  def find_destination(seed, list) do
    list
    |> Enum.reduce(seed, fn tuples, acc ->
      result =
        Enum.reduce_while(tuples, acc, fn {dest, source}, inner_acc ->
          if Enum.member?(source, inner_acc) do
            dif = inner_acc - source.first
            {:halt, dest.first + dif}
          else
            {:cont, inner_acc}
          end
        end)

      result
    end)
  end

  def compute(range, list) do
    Enum.reduce(range, :infinity, fn el, acc ->
      result =
        find_destination(el, list)

      case result < acc do
        true -> result
        _ -> acc
      end
    end)
    |> IO.inspect(label: "compute")
  end
end
