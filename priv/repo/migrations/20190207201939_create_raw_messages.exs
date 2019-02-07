defmodule MessageRoute.Repo.Migrations.CreateRawMessages do
  use Ecto.Migration

  def change do
    create table(:raw_messages) do
      add :topic, :string
      add :body, :string
      add :to, :string

      timestamps()
    end

  end
end
