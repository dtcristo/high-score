defmodule HighScore.ScoreView do
  use HighScore.Web, :view

  def render("index.json", %{scores: scores}) do
    %{data: render_many(scores, HighScore.ScoreView, "score.json")}
  end

  def render("show.json", %{score: score}) do
    %{data: render_one(score, HighScore.ScoreView, "score.json")}
  end

  def render("score.json", %{score: score}) do
    %{id: score.id,
      name: score.name,
      value: score.value,
      rank: score.rank,
      inserted_at: score.inserted_at}
  end
end
