defmodule MessageRoute.Topics.UserTopic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_topics" do
    field :subscribed, :boolean, default: false
    field :channel, :string
    belongs_to :user, MessageRoute.Accounts.User
    belongs_to :topic, MessageRoute.Topics.Topic

    timestamps()
  end

  @doc false
  def changeset(user_topic, attrs) do
    user_topic
    |> cast(attrs, [:subscribed, :channel])
    |> validate_required([:subscribed, :channel])
  end
end
