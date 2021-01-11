defmodule Proposition do
  defstruct [:description, yes: 0, no: 0]

  def new(description) do
    %__MODULE__{description: description}
  end

  defmacro vote({:+, _context, [prop, qty]}) do
    cast(prop, :yes, qty)
  end

  defmacro vote({:-, _context, [prop, qty]}) do
    cast(prop, :no, qty)
  end

  defp cast(prop, vote, qty) do
    quote do
      Map.update!(unquote(prop), unquote(vote), &(&1 + unquote(qty)))
    end
  end
end

# $ iex macro_proposition.exs
# Erlang/OTP 23 [erts-11.1.5] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [hipe]
#
# Interactive Elixir (1.11.3) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> import Proposition
# Proposition
# iex(2)> gas_tax = new("Gas Tax")
# %Proposition{
#   description: "Gas Tax",
#   no: 0,
#   yes: 0
# }
# iex(3)> vote gas_tax + 1
# %Proposition{
#   description: "Gas Tax",
#   no: 0,
#   yes: 1
# }
# iex(4)> vote gas_tax - 1
# %Proposition{
#   description: "Gas Tax",
#   no: 1,
#   yes: 0
# }
# iex(5)> (quote do: vote gas_tax + 2)
# {:vote,
#  [
#    context: Elixir,
#    import: Proposition
#  ],
#  [
#    {:+,
#     [
#       context: Elixir,
#       import: Kernel
#     ],
#     [
#       {:gas_tax,
#        [],
#        Elixir},
#       2
#     ]}
#  ]}
# iex(6)> (quote do: vote gas_tax + 2) |> Macro.expand(__ENV__)
# {{:.,
#   [],
#   [
#     {:__aliases__,
#      [
#        counter: -576460752303423036,
#        alias: false
#      ],
#      [:Map]},
#     :update!
#   ]},
#  [],
#  [
#    {:gas_tax,
#     [],
#     Elixir},
#    :yes,
#    {:&,
#     [],
#     [
#       {:+,
#        [
#          context: Proposition,
#          import: Kernel
#        ],
#        [
#          {:&,
#           [],
#           [1]},
#          2
#        ]}
#     ]}
#  ]}
# iex(7)> (quote do: vote gas_tax + 2) |> Macro.expand(__ENV__) |> Macro.to_string()
# "Map.update!(gas_tax, :yes, &(&1 + 2))"

