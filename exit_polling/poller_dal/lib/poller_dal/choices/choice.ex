defmodule PollerDal.Choices.Choice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "choices" do
    field(:description, :string)
    field(:votes, :integer)
    field(:party, :integer)

    belongs_to(:questions, PollerDal.Questions.Question)
  end

  def changeset(%__MODULE__{} = struct, attrs) do
    struct
    |> cast(attrs, [:description, :votes, :question_id, :party])
    |> validate_required([:description, :question_id, :party])
    |> assoc_constraint(:question)
  end
end
