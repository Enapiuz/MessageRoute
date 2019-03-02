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
    |> cast_assoc(:user, require: true, with: &MessageRoute.Accounts.User.changeset/2)
    |> cast_assoc(:topic, required: true, with: &MessageRoute.Topics.Topic.changeset/2)
    |> validate_required([:subscribed, :channel])
  end
end
