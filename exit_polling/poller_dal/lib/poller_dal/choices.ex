defmodule PollerDal.Choices do
  import Ecto.Query

  alias PollerDal.Repo
  alias PollerDal.Choices.Choice

  def list_choices_by_question_id(question_id) do
    from(
      c in Choice,
      where: c.question_id == ^question_id
    )
    |> Repo.all()
  end

  def list_choices_by_choice_ids(choice_ids) do
    from(
      c in Choice,
      where: c.id in ^choice_ids
    )
    |> Repo.all()
  end

  def get_choice!(id) do
    Repo.get!(Choice, id)
  end

  def create_choice(attrs) do
    %Choice{}
    |> Choice.changeset(attrs)
    |> Repo.insert()
  end

  def update_choice(%Choice{} = struct, attrs) do
    struct
    |> Choice.changeset(attrs)
    |> Repo.update()
  end

  def delete_choice(%Choice{} = struct) do
    Repo.delete(struct)
  end

  def change_choice(%Choice{} = struct) do
    Choice.changeset(struct, %{})
  end
end
