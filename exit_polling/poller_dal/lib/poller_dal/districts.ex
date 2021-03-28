defmodule PollerDal.Districts do
  alias PollerDal.Repo
  alias PollerDal.Districts.District

  def create_district(attrs) do
    %District{}
    |> District.changeset(attrs)
    |> Repo.insert()
  end

  def update_district(%District{} = struct, attrs) do
    struct
    |> District.changeset(attrs)
    |> Repo.update()
  end

  def delete_district(%District{} = struct) do
    Repo.delete(struct)
  end

  def list_districts, do: Repo.all(District)

  def get_district!(id), do: Repo.get!(District, id)
end
