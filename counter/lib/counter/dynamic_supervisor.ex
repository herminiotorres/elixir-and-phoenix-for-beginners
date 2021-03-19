defmodule Counter.DynamicSupervisor do
  use DynamicSupervisor

  def start_link(initial_args) do
    DynamicSupervisor.start_link(__MODULE__, initial_args, name: __MODULE__)
  end

  def init(_initial_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(initial_count, name) do
    spec = {Counter, initial_count: initial_count, name: name}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
