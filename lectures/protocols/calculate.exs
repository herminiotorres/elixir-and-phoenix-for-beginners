defmodule Calculate do
  def sum(data), do: Calculatable.sum(data)
end

defprotocol Calculatable do
  def sum(data)
end

defimpl Calculatable, for: List do
  def sum(list), do: do_sum(list, 0)

  defp do_sum([], total), do: total
  defp do_sum([head | tail], total), do: do_sum(tail, head + total)
end

defimpl Calculatable, for: Tuple do
  def sum(tuple), do: tuple |> Tuple.to_list() |> Calculatable.sum()
end
