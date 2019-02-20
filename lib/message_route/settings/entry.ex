defmodule MessageRoute.Settings.Entry do
  use Ecto.Schema
  import Ecto.Changeset


  schema "settings" do
    field :name, :string
    field :value, :binary

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:name, :value])
    |> validate_required([:name, :value])
  end
end
