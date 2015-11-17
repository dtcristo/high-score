defmodule HighScore.Score do
  use HighScore.Web, :model

  schema "scores" do
    field :name, :string
    field :value, :integer

    timestamps
  end

  @required_fields ~w(name value)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
