defmodule MessageRoute.Receiver.RawMessage do
  use Ecto.Schema
  import Ecto.Changeset


  schema "raw_messages" do
    field :body, :string
    field :to, :string
    field :topic, :string

    timestamps()
  end

  @doc false
  def changeset(raw_message, attrs) do
    raw_message
    |> cast(attrs, [:topic, :body, :to])
    |> validate_required([:topic, :body, :to])
  end
end
