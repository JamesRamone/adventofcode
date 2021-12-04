defmodule Day05 do
  def replace_one("B"), do: "1"
  def replace_one("F"), do: "0"
  def replace_one("L"), do: "0"
  def replace_one("R"), do: "1"

  def replace(line) do
    line
    |> String.split("", trim: true)
    |> Enum.map(&replace_one/1)
    |> List.to_string()
  end

  def to_integer({row, seat}), do: {String.to_integer(row, 2), String.to_integer(seat, 2)}
  def seat_id({row, seat}), do: row * 8 + seat
end

ids =
  File.read!("input")
  |> String.trim()
  |> String.split("\n")
  |> Enum.map(&Day05.replace/1)
  |> Enum.map(&String.split_at(&1, -3))
  |> Enum.map(&Day05.to_integer/1)
  |> Enum.map(&Day05.seat_id/1)
  |> Enum.sort()
  |> IO.inspect()

min = Enum.min(ids)
max = Enum.max(ids)
missing = Enum.sum(min..max) - Enum.sum(ids)

IO.puts(missing)
