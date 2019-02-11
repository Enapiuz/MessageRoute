defmodule MessageRoute.Topics do
  @moduledoc """
  The Topics context.
  """

  import Ecto.Query, warn: false
  alias MessageRoute.Repo

  alias MessageRoute.Topics.Topic

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic)
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(id), do: Repo.get!(Topic, id)

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{source: %Topic{}}

  """
  def change_topic(%Topic{} = topic) do
    Topic.changeset(topic, %{})
  end

  alias MessageRoute.Topics.UserTopic

  @doc """
  Returns the list of user_topics.

  ## Examples

      iex> list_user_topics()
      [%UserTopic{}, ...]

  """
  def list_user_topics do
    Repo.all(UserTopic)
  end

  @doc """
  Gets a single user_topic.

  Raises `Ecto.NoResultsError` if the User topic does not exist.

  ## Examples

      iex> get_user_topic!(123)
      %UserTopic{}

      iex> get_user_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_topic!(id), do: Repo.get!(UserTopic, id)

  @doc """
  Creates a user_topic.

  ## Examples

      iex> create_user_topic(%{field: value})
      {:ok, %UserTopic{}}

      iex> create_user_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_topic(attrs \\ %{}) do
    %UserTopic{}
    |> UserTopic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_topic.

  ## Examples

      iex> update_user_topic(user_topic, %{field: new_value})
      {:ok, %UserTopic{}}

      iex> update_user_topic(user_topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_topic(%UserTopic{} = user_topic, attrs) do
    user_topic
    |> UserTopic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserTopic.

  ## Examples

      iex> delete_user_topic(user_topic)
      {:ok, %UserTopic{}}

      iex> delete_user_topic(user_topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_topic(%UserTopic{} = user_topic) do
    Repo.delete(user_topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_topic changes.

  ## Examples

      iex> change_user_topic(user_topic)
      %Ecto.Changeset{source: %UserTopic{}}

  """
  def change_user_topic(%UserTopic{} = user_topic) do
    UserTopic.changeset(user_topic, %{})
  end
end
