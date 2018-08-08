defmodule Hnefatafl.PlayerSession do
  def login_player(conn, player) do
    conn
    |> Plug.Conn.put_session(:player_id, player.id)
    |> Plug.Conn.assign(:current_player, player)
    |> put_player_token(player)
  end

  def logout(conn) do
    conn
    |> Plug.Conn.delete_session(:player_id)
    |> Plug.Conn.assign(:current_player, nil)
  end

  def current_player(conn) do
    conn.assigns[:current_player] || load_current_player(conn)
  end

  defp load_current_player(conn) do
    id = Plug.Conn.get_session(conn, :player_id)

    if id do
      player = Hnefatafl.Repo.get!(Hnefatafl.Player, id)
      login_player(conn, player)
    end
  end

  defp put_player_token(conn, player) do
    salt = Application.get_env(:hnefatafl, :player_token_salt)
    token = Phoenix.Token.sign(conn, salt, player.id)
    Plug.Conn.put_session(conn, :player_token, token)
  end
end
