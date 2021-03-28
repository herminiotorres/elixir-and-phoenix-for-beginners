defmodule PollerDal.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field(:description, :string)
    belongs_to(:district, PollerDal.Districts.District)

    timestamps()
  end

  def changeset(%__MODULE__{} = struct, attrs) do
    struct
    |> cast(attrs, [:description, :district_id])
    |> validate_required([:description, :district_id])
    |> assoc_constraint(:district)
  end
end
