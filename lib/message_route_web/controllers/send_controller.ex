defmodule MessageRouteWeb.SendController do
  use MessageRouteWeb, :controller

  def index(conn, params) do
    case MessageRoute.Receiver.create_raw_message(params) do
      {:ok, _message} ->
        conn
        |> render("send.json", %{ok: true})
      {:error, _changeset} ->
        conn
        |> render("send.json", %{ok: false})
    end
  end
end
