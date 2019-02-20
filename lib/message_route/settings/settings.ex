defmodule MessageRoute.Settings do
  @moduledoc """
  The Settings context.
  """

  import Ecto.Query, warn: false
  alias MessageRoute.Repo

  alias MessageRoute.Settings.Entry
  alias MessageRoute.Settings.Cache

  @spec get(String.t()) :: {:error} | {:ok, any()}
  def get(name) when is_bitstring(name) do
    Cache.get(name)
  end

  @spec set(String.t(), any()) :: any()
  def set(name, value) when is_bitstring(name) do
    encoded_value = :erlang.term_to_binary(value)
    %{name: name, value: encoded_value}
    |> create_entry()
    Cache.set(name, value)
  end

  @doc """
  Returns the list of settings.

  ## Examples

      iex> list_settings()
      [%Entry{}, ...]

  """
  def list_settings do
    Repo.all(Entry)
  end

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(id), do: Repo.get!(Entry, id)

  @doc """
  Creates a entry.

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert(on_conflict: {:replace, [:value]}, conflict_target: :name)
  end

  @doc """
  Updates a entry.

  ## Examples

      iex> update_entry(entry, %{field: new_value})
      {:ok, %Entry{}}

      iex> update_entry(entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entry(%Entry{} = entry, attrs) do
    entry
    |> Entry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Entry.

  ## Examples

      iex> delete_entry(entry)
      {:ok, %Entry{}}

      iex> delete_entry(entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entry(%Entry{} = entry) do
    Repo.delete(entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entry changes.

  ## Examples

      iex> change_entry(entry)
      %Ecto.Changeset{source: %Entry{}}

  """
  def change_entry(%Entry{} = entry) do
    Entry.changeset(entry, %{})
  end
end
