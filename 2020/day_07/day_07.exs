defmodule Day07 do
  def invert(tree) do
    Enum.reduce(tree, %{}, fn {parent, children}, inverted_tree ->
      Enum.reduce(children, inverted_tree, fn {_n, child}, inverted_tree ->
        Map.update(inverted_tree, child, [parent], &[parent | &1])
      end)
    end)
  end

  def parse_rule(line, acc) do
    [type | contains] = line |> String.split(["bags", "bag", " contain ", ",", "."], trim: true)

    Map.put(acc, type, Day07.parse_children(contains))
  end

  def parse_children("no other"), do: []

  def parse_children(children) do
    children
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [num | type] -> {num, Enum.join(type, " ")} end)
  end

  def count_ancestors(itree, name), do: count_ancestors([name], MapSet.new(), itree)

  def count_ancestors([], bags, _itree), do: Enum.count(bags)

  def count_ancestors([name | rest], bags, itree) do
    case Map.fetch(itree, name) do
      :error -> count_ancestors(rest, bags, itree)
      {:ok, names} -> count_ancestors(names ++ rest, MapSet.union(bags, MapSet.new(names)), itree)
    end
  end
end

_rules =
  File.read!("input")
  |> String.trim()
  |> String.split("\n")
  |> Enum.reduce(%{}, &Day07.parse_rule/2)
  |> IO.inspect()
  |> Day07.invert()
  |> Day07.count_ancestors("shiny gold")
  |> IO.inspect()
