defmodule MessageRoute.Settings.Supervisor do
  use Supervisor

  def start_link(_opts) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(MessageRoute.Settings.Storage, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
