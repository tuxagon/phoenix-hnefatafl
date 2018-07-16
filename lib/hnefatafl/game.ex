defmodule Hnefatafl.Game do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, nil, name: via_registry(name))
  end

  def via_registry(name) do
    {:via, Registry, {Hnefatafl.Registry, name}}
  end

  @impl true
  def init(_) do
    {:ok, []}
  end
end
