defmodule HnefataflWeb.LobbyController do
  use HnefataflWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
