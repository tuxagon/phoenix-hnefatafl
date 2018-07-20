defmodule Hnefatafl.Board do
  # HNEFATAFL BOARD SETUP
  #
  #      0   1   2   3   4   5   6   7   8   9  10
  #   +---+---+---+---+---+---+---+---+---+---+---+
  #  0| X |   |   | A | A | A | A | A |   |   | X |
  #   +---+---+---+---+---+---+---+---+---+---+---+
  #  1|   |   |   |   |   | A |   |   |   |   |   |
  #   +---+---+---+---+---+---+---+---+---+---+---+
  #  2|   |   |   |   |   |   |   |   |   |   |   |
  #   +---+---+---+---+---+---+---+---+---+---+---+
  #  3| A |   |   |   |   | D |   |   |   |   | A |
  #   +---+---+---+---+---+---+---+---+---+---+---+
  #  4| A |   |   |   | D | D | D |   |   |   | A |
  #   +---+---+---+---+---+---+---+---+---+---+---+
  #  5| A | A |   | D | D |K/X| D | D |   | A | A |
  #   +---+---+---+---+---+---+---+---+---+---+---+
  #  6| A |   |   |   | D | D | D |   |   |   | A |
  #   +---+---+---+---+---+---+---+---+---+---+---+
  #  7| A |   |   |   |   | D |   |   |   |   | A |
  #   +---+---+---+---+---+---+---+---+---+---+---+
  #  8|   |   |   |   |   |   |   |   |   |   |   |
  #   +---+---+---+---+---+---+---+---+---+---+---+
  #  9|   |   |   |   |   | A |   |   |   |   |   |
  #   +---+---+---+---+---+---+---+---+---+---+---+
  # 10| X |   |   | A | A | A | A | A |   |   | X |
  #   +---+---+---+---+---+---+---+---+---+---+---+

  defmodule Cell do
    defstruct [:type, :hotspot?]
  end

  def new do
    # these names are not great and the reasoning behind
    # them is so that `mix format` would keep everything
    # aligned after formatting
    {kng, atk, dfn, xxx} = {
      %Cell{type: :king, hotspot?: true},
      %Cell{type: :attacker, hotspot?: false},
      %Cell{type: :defender, hotspot?: false},
      %Cell{hotspot?: true}
    }

    [
      [xxx, nil, nil, atk, atk, atk, atk, atk, nil, nil, xxx],
      [nil, nil, nil, nil, nil, atk, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [atk, nil, nil, nil, nil, dfn, nil, nil, nil, nil, atk],
      [atk, nil, nil, nil, dfn, dfn, dfn, nil, nil, nil, atk],
      [atk, atk, nil, dfn, dfn, kng, dfn, dfn, nil, atk, atk],
      [atk, nil, nil, nil, dfn, dfn, dfn, nil, nil, nil, atk],
      [atk, nil, nil, nil, nil, dfn, nil, nil, nil, nil, atk],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, atk, nil, nil, nil, nil, nil],
      [xxx, nil, nil, atk, atk, atk, atk, atk, nil, nil, xxx]
    ]
  end

  def cell_at(board, {x, y}) do
    Enum.at(Enum.at(board, y), x)
  end

  def attacker?(%Cell{type: type}), do: :attacker == type
  def attacker?(nil), do: false

  def defender?(%Cell{type: type}), do: :defender == type
  def defender?(nil), do: false

  def hotspot?(%Cell{type: type, hotspot?: is_hotspot}) do
    :king != type && is_hotspot
  end

  def hotspot?(nil), do: false

  def king?(%Cell{type: type}), do: :king == type
  def king?(nil), do: false

  def empty?(%Cell{type: type}), do: is_nil(type)
  def empty?(nil), do: true
end
