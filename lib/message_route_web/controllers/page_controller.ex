defmodule MessageRouteWeb.PageController do
  use MessageRouteWeb, :controller

  alias MessageRoute.Settings

  def index(conn, _params) do
    slack_token =
      case Settings.get("slack_token") do
        {:ok, token} -> token
        {:error} -> ""
      end
    render(conn, "index.html", token: slack_token)
  end

  def update_token(conn, %{"data" => %{"token" => token}} = _params) do
    Settings.set("slack_token", token)
    conn
    |> redirect(to: "/")
  end
end
