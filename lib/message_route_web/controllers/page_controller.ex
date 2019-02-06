defmodule MessageRouteWeb.PageController do
  use MessageRouteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
