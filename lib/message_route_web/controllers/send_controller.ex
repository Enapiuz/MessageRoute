defmodule MessageRouteWeb.SendController do
  use MessageRouteWeb, :controller

  alias MessageRoute.Receiver

  def index(conn, params) do
    result =
      params
      |> Receiver.create_raw_message()
      |> Receiver.send_raw_message()
    data = case result do
      {:ok, message} -> %{ok: true, message: message}
      {:error, changeset} -> %{ok: false, changeset: changeset}
    end
    conn
    |> render("send.json", data)
  end
end
