defmodule Day9Part2 do
  def run do
    sequence =
      File.read!("input")
      |> parse()

    {:error, num} =
      sequence
      |> get_preamble()
      |> execute()
      |> IO.inspect()

    sequence
    |> find_list(num)
    |> IO.inspect()
  end

  def find_list(seq, num) do
    indexed = Enum.with_index(seq)

    for {_, m} <- indexed,
        {_, n} <- indexed,
        Enum.sum(Enum.slice(seq, m..n)) == num,
        do: Enum.min(Enum.slice(seq, m..n)) + Enum.max(Enum.slice(seq, m..n))
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def execute({preamble, [current | tail]}) do
    case find(current, preamble) do
      true -> execute({Enum.take(preamble ++ [current], -25), tail})
      false -> {:error, current}
    end
  end

  def execute({_, []}), do: {:finished}

  def find(num, nums) do
    Enum.any?(nums, fn x ->
      Enum.find(nums, fn y ->
        y == num - x
      end)
    end)
  end

  def get_preamble(input) do
    {Enum.take(input, 25), Enum.slice(input, 25..-1)}
  end
end

Day9Part2.run()
