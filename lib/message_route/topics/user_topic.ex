defmodule MessageRoute.Topics.UserTopic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_topics" do
    field :subscribed, :boolean, default: false
    field :user_id, :id
    field :topic_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_topic, attrs) do
    user_topic
    |> cast(attrs, [:subscribed])
    |> validate_required([:subscribed])
  end
end
