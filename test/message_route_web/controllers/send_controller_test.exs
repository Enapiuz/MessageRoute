defmodule MessageRouteWeb.SendControllerTest do
  use MessageRouteWeb.ConnCase

  test "POST /api/send", %{conn: conn} do
    params = %{
      to: "test@example.com",
      topic: "test.topic",
      body: "test body",
    }
    conn = post(conn, "/api/send", params)
    assert json_response(conn, 200) == %{"ok" => false}
  end
end
