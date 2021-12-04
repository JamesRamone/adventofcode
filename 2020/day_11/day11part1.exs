defmodule Day11Part1 do
  def run do
    plan =
      File.read!("input")
      |> parse()
      |> input_to_map()
      |> IO.inspect()
  end

  def apply_rules(plan, new_plan) do
    plan |> Enum.each()
  end

  def apply_single({{x, y}, "."}), do: "."

  def apply_single({{x, y}, "#"}) do
  end

  def apply_single({{x, y}, "L"}) do
  end

  def check_neighbors({x, y}, plan) do
    acc = 0
    for i <- (x - 1)..(x + 1), j <- (y - 1)..(y + 1), do: if(plan[{x, y}] == "#", do: acc + 1)
  end

  # {{row, col}, L}
  def input_to_map(plan) do
    for {row, i} <- plan, {seat, j} <- row, %{}, do: {{i, j}, seat}
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(&Enum.with_index/1)
    |> Enum.with_index()
  end
end

Day11Part1.run()
