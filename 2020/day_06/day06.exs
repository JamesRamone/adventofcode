defmodule Day06 do
  def group_answers(group, total) do
    count = length(group)

    group
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.reduce(%{}, &Day06.reduce_single/2)
    |> Enum.count(fn {_, v} -> v == count end)
    |> Kernel.+(total)
  end

  def reduce_single(line, acc) do
    line |> Enum.reduce(acc, &Map.update(&2, &1, 1, fn v -> v + 1 end))
  end

  # part1
  # def group_answers(group, total) do
  #   set = for q <- group, into: MapSet.new(), do: q

  #   total + MapSet.size(set)
  # end
end

ids =
  File.read!("input")
  |> String.trim()
  |> String.split("\n\n")
  |> Enum.map(&String.split(&1, "\n", trim: true))
  # |> IO.inspect()
  # |> Enum.map(&String.split(&1, "", trim: true))
  # |> IO.inspect()
  |> Enum.reduce(0, &Day06.group_answers/2)
  |> IO.inspect()
