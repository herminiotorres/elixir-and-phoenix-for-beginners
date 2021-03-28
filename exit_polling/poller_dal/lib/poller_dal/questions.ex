defmodule PollerDal.Questions do
  import Ecto.Query

  alias PollerDal.Repo
  alias PollerDal.Questions.Question

  def list_questions_by_district_id(district_id) do
    from(
      q in Question,
      where: q.district_id == ^district_id
    )
    |> Repo.all()
  end

  def create_question(attrs) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  def update_question(%Question{} = struct, attrs) do
    struct
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  def delete_question(%Question{} = struct) do
    Repo.delete(struct)
  end

  def list_questions do
    Question
    |> preload(:district)
    |> Repo.all()
  end

  def get_question!(id), do: Repo.get!(Question, id)
end
