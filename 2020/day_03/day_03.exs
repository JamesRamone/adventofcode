defmodule Day03 do
  def check_line(line, state, addX) do
    if String.at(line, state.x) == "#" do
      %{:trees => state.trees + 1, :x => rem(state.x + addX, String.length(line))}
    else
      Map.update!(state, :x, &rem(&1 + addX, String.length(line)))
    end
  end

  def reduce_lines(lines, options) do
    {x, y} = options

    lines
    |> Enum.take_every(y)
    |> Enum.reduce(%{:x => 0, :trees => 0}, fn l, acc -> Day03.check_line(l, acc, x) end)
  end
end

lines =
  File.read!("input")
  |> String.trim()
  |> String.split("\n")

options = [
  {1, 1},
  {3, 1},
  {5, 1},
  {7, 1},
  {1, 2}
]

options
|> Enum.map(&Day03.reduce_lines(lines, &1).trees)
|> IO.inspect()
|> Enum.reduce(1, &(&1 * &2))
|> IO.inspect()

# lines
# |> Enum.reduce(%{:x => 1, :trees => 0}, &Day03.check_line/2)
# |> IO.inspect()
