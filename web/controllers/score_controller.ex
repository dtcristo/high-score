defmodule HighScore.ScoreController do
  use HighScore.Web, :controller

  alias HighScore.Score

  plug :scrub_params, "score" when action in [:create, :update]

  def index(conn, _params) do
    scores = Repo.all(from s in Score,
                      order_by: [desc: s.value, asc: s.inserted_at],
                      limit: 10)
             |> put_ranks()
    render(conn, "index.json", scores: scores)
  end

  def create(conn, %{"score" => score_params}) do
    changeset = Score.changeset(%Score{}, score_params)

    case Repo.insert(changeset) do
      {:ok, score} ->
        score = put_rank(score)
        conn
        |> put_status(:created)
        |> put_resp_header("location", score_path(conn, :show, score))
        |> render("show.json", score: score)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HighScore.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    score = Repo.get!(Score, id)
            |> put_rank()
    render(conn, "show.json", score: score)
  end

  # Set ranks on a sorted list of scores, starting at 1
  defp put_ranks(scores) do
    Enum.map_reduce(scores, 1, fn(score, rank) ->
                                 {%{score | rank: rank}, rank + 1}
                               end) |> elem(0)
  end

  # Calculate rank and add to score struct
  defp put_rank(score) do
    # Get the rank of the new score
    rank = Repo.one from s in Score,
                    where: s.value >= ^score.value,
                    select: count(s.id)

    # Return score with rank
    %{score | rank: rank}
  end

  # def update(conn, %{"id" => id, "score" => score_params}) do
  #   score = Repo.get!(Score, id)
  #   changeset = Score.changeset(score, score_params)
  #
  #   case Repo.update(changeset) do
  #     {:ok, score} ->
  #       render(conn, "show.json", score: score)
  #     {:error, changeset} ->
  #       conn
  #       |> put_status(:unprocessable_entity)
  #       |> render(HighScore.ChangesetView, "error.json", changeset: changeset)
  #   end
  # end
  #
  # def delete(conn, %{"id" => id}) do
  #   score = Repo.get!(Score, id)
  #
  #   # Here we use delete! (with a bang) because we expect
  #   # it to always work (and if it does not, it will raise).
  #   Repo.delete!(score)
  #
  #   send_resp(conn, :no_content, "")
  # end
end
