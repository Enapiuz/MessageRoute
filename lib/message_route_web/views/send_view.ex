defmodule MessageRouteWeb.SendView do
  use MessageRouteWeb, :view

  def render("send.json", %{ok: ok?}) do
    %{
      ok: ok?
    }
  end
end
