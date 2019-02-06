defmodule MessageRoute.Repo do
  use Ecto.Repo,
    otp_app: :message_route,
    adapter: Ecto.Adapters.Postgres
end
