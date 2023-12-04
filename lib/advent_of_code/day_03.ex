defmodule AdventOfCode.Day03 do
  # defp process_line(line, row_idx, interest, numbers) do
  #   regex = ~r{[\&\*\+\$\#\%\@\!]}
  #   col_idx = 0
  #
  #   String.split(line, "", trim: true)
  #   |> IO.inspect(label: "char line")
  #   |> Enum.reduce(numbers, fn char, acc ->
  #     with {:ok, val} <- Integer.parse(char) do
  #       Map.update(acc, row_idx, [])
  #     else
  #       with true <- String.match?(char, regex) do
  #       end
  #     end
  #
  #     acc
  #   end)
  # end

  def part1(_input) do
    # lines =
    #   String.split(input, ~r{\n}, trim: true)
    #   |> IO.inspect()
    #   |> Enum.reduce({0, %{}, %{}}, fn line, {row_idx, interest_sigle, numbers_map} ->
    #     process_line(line, row_idx, interest_sigle, numbers_map)
    #
    #     {row_idx + 1, interest_sigle, numbers_map}
    #   end)
  end

  def part2(_args) do
  end
end
