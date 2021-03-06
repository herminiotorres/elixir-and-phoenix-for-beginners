defmodule Poller.Question do
  defstruct(
    id: nil,
    description: nil,
    choices: []
  )

  def new(id, description) do
    %__MODULE__{
      id: id,
      description: description
    }
  end

  def add_choice(question, choice) do
    choices = [choice | question.choices]
    Map.put(question, :choices, choices)
  end
end
