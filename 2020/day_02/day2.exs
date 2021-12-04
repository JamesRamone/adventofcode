defmodule Day2 do
  def validate([policy, letter, password]) do
    [m, n] = String.split(policy, "-") |> Enum.map(&String.to_integer/1)
    range = m..n

    count =
      password
      |> String.split("", trim: true)
      |> Enum.filter(&(&1 == letter))
      |> Enum.count()

    Enum.member?(range, count)
  end

  def validate2([policy, letter, password]) do
    [m, n] = String.split(policy, "-") |> Enum.map(&String.to_integer/1)

    map =
      password
      |> String.split("", trim: true)
      |> Enum.with_index(1)
      |> Map.new(fn {k, v} -> {v, k} end)

    (map[m] == letter && map[n] != letter) ||
      (map[m] != letter && map[n] == letter)
  end
end

count =
  File.read!("input")
  |> String.trim()
  |> String.split("\n")
  |> Enum.map(fn x -> String.split(x, [":", " "], trim: true) end)
  |> Enum.filter(&Day2.validate2/1)
  |> Enum.count()

IO.puts(count)
