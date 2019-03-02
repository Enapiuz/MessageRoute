defmodule MessageRouteWeb.PageControllerTest do
  use MessageRouteWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Message Route"
  end
end
