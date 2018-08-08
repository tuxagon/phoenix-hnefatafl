defmodule HnefataflWeb.LobbyView do
  use HnefataflWeb, :view

  def player_authorized?(conn) do
    player_token(conn) != nil
  end

  def player_token(conn) do
    Plug.Conn.get_session(conn, :player_token)
  end

  def player_id(conn) do
    Plug.Conn.get_session(conn, :player_id)
  end
end
