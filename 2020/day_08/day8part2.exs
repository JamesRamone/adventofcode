defmodule Day8Part2 do
  def run do
    File.read!("input")
    |> input_to_map()
    |> IO.inspect()
  end

  def input_to_map(input) do
    input
    |> String.split("\n", trim: true)
    # |> Enum.with_index()
    # |> Enum.into(%{}, fn {ins, ln} -> {ln, ins} end)
    |> execute(MapSet.new(), {0, 0})
    |> IO.inspect()
  end

  def execute(prog, executed, {pc, acc}) do
    case MapSet.member?(executed, pc) do
      true ->
        acc

      false ->
        execute(prog, MapSet.put(executed, pc), exec_instruction(Enum.at(prog, pc, ""), pc, acc))
    end
  end

  def exec_instruction("acc " <> num, pc, acc), do: {pc + 1, acc + String.to_integer(num)}
  def exec_instruction("nop " <> _, pc, acc), do: {pc + 1, acc}
  def exec_instruction("jmp " <> num, pc, acc), do: {pc + String.to_integer(num), acc}
  def exec_instruction(_, pc, acc), do: {pc + 1, acc}
end

Day8Part2.run()
