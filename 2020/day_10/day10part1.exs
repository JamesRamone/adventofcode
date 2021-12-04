defmodule Day10Part1 do
  def run do
    adapters =
      File.read!("input")
      |> parse()
      |> Enum.sort()

    max = (Enum.max(adapters) + 3) |> IO.inspect()

    diff([0 | adapters] ++ [max], max, %{})
    |> multiply_diffs()
    |> IO.inspect()
  end

  def multiply_diffs(%{:one => x, :three => y}), do: x * y

  def diff([_ | []], _max, diffs), do: diffs

  def diff([head | tail], max, diffs) do
    [first | _] = tail

    case first - head do
      1 -> diff(tail, max, Map.update(diffs, :one, 1, &(&1 + 1)))
      3 -> diff(tail, max, Map.update(diffs, :three, 1, &(&1 + 1)))
      _ -> diff(tail, max, diffs)
    end
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end

Day10Part1.run()
