defmodule PollerDal.Districts.District do
  use Ecto.Schema
  import Ecto.Changeset

  schema "districts" do
    field(:name, :string)

    timestamps()
  end

  def changeset(%__MODULE__{} = struct, %{} = attrs) do
    struct
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 2)
  end
end
