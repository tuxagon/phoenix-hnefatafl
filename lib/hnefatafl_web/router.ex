defmodule HnefataflWeb.Router do
  use HnefataflWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", HnefataflWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", LobbyController, :index)
    get("/session", SessionController, :new)
    post("/session", SessionController, :create)
  end

  # Other scopes may use custom stacks.
  # scope "/api", HnefataflWeb do
  #   pipe_through :api
  # end
end
