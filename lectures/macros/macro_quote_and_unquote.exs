defmodule Util do
  # iex(1)> a = 1
  # 1
  # iex(2)> b = 2
  # 2
  # iex(3)> quote do: a + b
  # {:+, [ context: Elixir, import: Kernel ], [ {:a, [], Elixir}, {:b, [], Elixir} ]}
  # iex(3)> quote do: unquote(a) + unquote(b)
  # {:+, [ context: Elixir, import: Kernel ], [1, 2]}

  defmacro reverse({:+, context, [a, b]}) do
    quote do
      unquote(a) - unquote(b)
    end
  end
end
