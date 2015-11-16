defmodule HighScore.ScoreController do
  use HighScore.Web, :controller

  def index(conn, _params) do
    json conn, [%{name: "David", score: 1337, rank: 1},
                %{name: "Bunts", score: 1021, rank: 2},
                %{name: "Erik", score: 99, rank: 3},
                %{name: "Dim", score: 70, rank: 4},
                %{name: "Phil", score: 69, rank: 5}]
  end

  def create(conn, _params) do
    score = %{name: "David", score: 9000}
            |> Dict.put(:rank, 1)
            
    conn
    |> put_status(201)
    |> json(score)
  end
end
