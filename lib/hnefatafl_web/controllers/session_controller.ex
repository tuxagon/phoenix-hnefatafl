defmodule HnefataflWeb.SessionController do
  use HnefataflWeb, :controller

  alias Hnefatafl.Player
  alias Hnefatafl.PlayerSession
  alias Hnefatafl.Repo

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"name" => name}) do
    changeset = Player.changeset(%Player{}, %{name: name})

    case Repo.insert(changeset) do
      {:ok, player} ->
        conn
        |> PlayerSession.login_player(player)
        |> redirect(to: lobby_path(conn, :index))

      _ ->
        render("new.html")
    end
  end
end
