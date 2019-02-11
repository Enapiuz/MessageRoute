defmodule MessageRoute.Repo.Migrations.CreateUserTopics do
  use Ecto.Migration

  def change do
    create table(:user_topics) do
      add :subscribed, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :topic_id, references(:topics, on_delete: :nothing)

      timestamps()
    end

    create index(:user_topics, [:user_id])
    create index(:user_topics, [:topic_id])
  end
end
