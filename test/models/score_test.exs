defmodule HighScore.ScoreTest do
  use HighScore.ModelCase

  alias HighScore.Score

  @valid_attrs %{name: "some content", value: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Score.changeset(%Score{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Score.changeset(%Score{}, @invalid_attrs)
    refute changeset.valid?
  end
end
