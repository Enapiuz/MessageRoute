defmodule MessageRoute.Repo.Migrations.CreateRawMessages do
  use Ecto.Migration

  def change do
    create table(:raw_messages) do
      add :topic, :string
      add :body, :string
      add :to, :string
      add :done, :boolean, default: false

      timestamps()
    end

  end
end
