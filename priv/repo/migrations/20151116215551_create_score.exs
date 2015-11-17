defmodule HighScore.Repo.Migrations.CreateScore do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :name, :string
      add :value, :integer

      timestamps
    end

  end
end
