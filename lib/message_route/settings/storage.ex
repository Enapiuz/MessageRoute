defmodule MessageRoute.Settings.Storage do
  use GenServer

  alias MessageRoute.Settings

  def start_link(_opts \\ []) do
    GenServer.start_link(
      __MODULE__,
      [
        {:ets_table_name, :settings_cache_table},
        {:log_limit, 1_000_000}
      ],
      [name: __MODULE__]
    )
  end

  def fetch(slug, default_value_function) do
    case get(slug) do
      {:error} -> set(slug, default_value_function.())
      {:ok, result} -> result
    end
  end

  @spec get(any()) :: {:error} | {:ok, any()}
  def get(slug) do
    case GenServer.call(__MODULE__, {:get, slug}) do
      [] -> {:error}
      [{_slug, result}] -> {:ok, result}
    end
  end

  @spec set(String.t(), any()) :: any()
  def set(slug, value) do
    GenServer.call(__MODULE__, {:set, slug, value})
  end

  # GenServer callbacks

  def handle_call({:get, slug}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.lookup(ets_table_name, slug)
    {:reply, result, state}
  end

  def handle_call({:set, slug, value}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    true = :ets.insert(ets_table_name, {slug, value})
    {:reply, value, state}
  end

  def init(args) do
    [{:ets_table_name, ets_table_name}, {:log_limit, log_limit}] = args

    :ets.new(ets_table_name, [:named_table, :set, :private])

    {:ok, %{log_limit: log_limit, ets_table_name: ets_table_name}, {:continue, :more_init}}
  end

  @spec handle_continue(:more_init, %{ets_table_name: any()}) ::
          {:noreply, %{ets_table_name: any()}}
  def handle_continue(:more_init, state) do
    %{ets_table_name: ets_table_name} = state

    Settings.list_settings()
    |> Enum.each(fn entry ->
      %{name: name, value: value} = entry
      true = :ets.insert(ets_table_name, {name, :erlang.binary_to_term(value)})
    end)

    {:noreply, state}
  end
end
