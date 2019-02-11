defmodule MessageRoute.Messages do
  @moduledoc """
  The Messages context.
  Stores raw messages and sends them to the exchange context.
  """

  import Ecto.Query, warn: false
  alias MessageRoute.Repo

  alias MessageRoute.Exchange
  alias MessageRoute.Messages.RawMessage

  @doc """
  Sends message to user.
  """
  def send(result) do
    case result do
      {:ok, message} ->
        Exchange.push(message)

      _ ->
        result
    end
  end

  @doc """
  Returns the list of raw_messages.

  ## Examples

      iex> list_raw_messages()
      [%RawMessage{}, ...]

  """
  def list_raw_messages do
    Repo.all(RawMessage)
  end

  @doc """
  Gets a single raw_message.

  Raises `Ecto.NoResultsError` if the Raw message does not exist.

  ## Examples

      iex> get_raw_message!(123)
      %RawMessage{}

      iex> get_raw_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_raw_message!(id), do: Repo.get!(RawMessage, id)

  @doc """
  Creates a raw_message.

  ## Examples

      iex> create_raw_message(%{field: value})
      {:ok, %RawMessage{}}

      iex> create_raw_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_raw_message(attrs \\ %{}) do
    %RawMessage{}
    |> RawMessage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a raw_message.

  ## Examples

      iex> update_raw_message(raw_message, %{field: new_value})
      {:ok, %RawMessage{}}

      iex> update_raw_message(raw_message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_raw_message(%RawMessage{} = raw_message, attrs) do
    raw_message
    |> RawMessage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Marks message as sent.

  ## Examples

      iex> mark_raw_message_sent(raw_message)
      {:ok, %RawMessage{done: true}}

  """
  def mark_raw_message_sent(%RawMessage{} = message) do
    update_raw_message(message, %{done: true})
  end

  @doc """
  Deletes a RawMessage.

  ## Examples

      iex> delete_raw_message(raw_message)
      {:ok, %RawMessage{}}

      iex> delete_raw_message(raw_message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_raw_message(%RawMessage{} = raw_message) do
    Repo.delete(raw_message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking raw_message changes.

  ## Examples

      iex> change_raw_message(raw_message)
      %Ecto.Changeset{source: %RawMessage{}}

  """
  def change_raw_message(%RawMessage{} = raw_message) do
    RawMessage.changeset(raw_message, %{})
  end
end
