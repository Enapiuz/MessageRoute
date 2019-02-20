defmodule MessageRoute.Topics.Topic do
  use Ecto.Schema
  import Ecto.Changeset


  schema "topics" do
    field :name, :string
    # has_many :user_topics, MessageRoute.Topics.UserTopic

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
