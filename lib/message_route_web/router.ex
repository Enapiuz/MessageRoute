defmodule MessageRouteWeb.Router do
  use MessageRouteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MessageRouteWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/update_slack_token", PageController, :update_token
    get "/user", UserController, :index
    put "/user", UserController, :update
  end

  # Other scopes may use custom stacks.
  scope "/api", MessageRouteWeb do
    pipe_through :api

    post "/send", SendController, :index
  end
end
