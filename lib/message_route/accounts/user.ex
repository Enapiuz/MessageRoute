defmodule MessageRoute.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    has_many :topics, MessageRoute.Topics.UserTopic

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> cast_assoc(:topics, required: false, with: &MessageRoute.Topics.UserTopic.changeset/2)
    |> validate_required([:email])
  end
end
