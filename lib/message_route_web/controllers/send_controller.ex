defmodule MessageRouteWeb.SendController do
  use MessageRouteWeb, :controller

  alias MessageRoute.Messages

  def index(conn, params) do
    result =
      params
      |> Messages.create_raw_message()
      |> Messages.send()

    data =
      case result do
        {:ok, message} -> %{ok: true, message: message}
        {:error, changeset} -> %{ok: false, changeset: changeset}
      end

    conn
    |> render("send.json", data)
  end
end
