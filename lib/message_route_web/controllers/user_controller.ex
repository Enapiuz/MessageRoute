defmodule MessageRouteWeb.UserController do
  use MessageRouteWeb, :controller

  alias MessageRoute.Accounts

  def index(conn, %{"email" => email} = _params) do
    user = Accounts.get_or_create_user_by_email(email)
    render(conn, "index.html", changeset: Accounts.change_user(user))
  end

  def update(conn, %{"user" => %{"email" => email} = updated_user} = params) do
    Accounts.get_or_create_user_by_email(email)
    |> Accounts.update_user(updated_user)

    conn
    |> put_flash(:info, "Updated successfully!")
    |> redirect(to: Routes.user_path(conn, :index, email: "slack@vadim.mm.st"))
  end
end
