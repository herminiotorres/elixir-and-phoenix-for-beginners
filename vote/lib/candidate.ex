defmodule Candidate do
  defstruct [:id, :name, votes: 0]

  def new(id, name) do
    %__MODULE__{id: id, name: name}
  end
end
