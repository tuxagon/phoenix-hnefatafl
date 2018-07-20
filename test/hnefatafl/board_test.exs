defmodule Hnefatafl.BoardTest do
  use ExUnit.Case, async: true

  alias Hnefatafl.Board
  alias Hnefatafl.Board.Cell

  @hotspot_locations [
    {0, 0},
    {0, 10},
    {10, 0},
    {10, 10}
  ]
  @attacker_locations [
    {3, 0},
    {4, 0},
    {5, 0},
    {6, 0},
    {7, 0},
    {5, 1},
    {0, 3},
    {0, 4},
    {0, 5},
    {0, 6},
    {0, 7},
    {1, 5},
    {3, 10},
    {4, 10},
    {5, 10},
    {6, 10},
    {7, 10},
    {5, 9},
    {10, 3},
    {10, 4},
    {10, 5},
    {10, 6},
    {10, 7},
    {9, 5}
  ]
  @defender_locations [
    {3, 5},
    {4, 4},
    {4, 5},
    {4, 6},
    {5, 3},
    {5, 4},
    {5, 6},
    {5, 7},
    {6, 4},
    {6, 5},
    {6, 6},
    {7, 5}
  ]
  @king_location {5, 5}
  @total_empty 84

  test "cell_at/2 retrieves the correct index in 2D list" do
    original = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    constructed =
      Enum.map(0..2, fn y ->
        Enum.map(0..2, fn x ->
          Board.cell_at(original, {x, y})
        end)
      end)

    assert original == constructed
  end

  test "attacker?/1 returns true when cell has attacker" do
    assert Board.attacker?(%Cell{type: :attacker})
  end

  test "attacker?/1 returns false when cell is not an attacker" do
    refute Board.attacker?(%Cell{type: :defender})
  end

  test "defender?/1 returns true when cell has defender" do
    assert Board.defender?(%Cell{type: :defender})
  end

  test "defender?/1 returns false when cell is not a defender" do
    refute Board.defender?(%Cell{type: :attacker})
  end

  test "hotspot?/1 returns true when cell is a hotspot" do
    assert Board.hotspot?(%Cell{type: nil, hotspot?: true})
  end

  test "hotspot?/1 returns false when cell is not a hotspot" do
    refute Board.hotspot?(%Cell{type: :attacker, hotspot?: false})
  end

  test "hotspot?/1 returns false when king is on the hotspot" do
    refute Board.hotspot?(%Cell{type: :king, hotspot?: true})
  end

  test "king?/1 returns true when cell has king" do
    assert Board.king?(%Cell{type: :king})
  end

  test "king?/1 returns false when cell does not hold the king" do
    refute Board.king?(%Cell{type: :defender})
  end

  test "empty?/1 returns true when cell is empty" do
    assert Board.empty?(nil)
    assert Board.empty?(%Cell{type: nil})
  end

  test "empty?/1 returns false when cell is occupied" do
    refute Board.empty?(%Cell{type: :defender})
  end

  test "new/0 correct number of attackers" do
    num_attackers =
      Enum.reduce(Board.new(), 0, fn row, acc ->
        acc + Enum.count(row, &Board.attacker?/1)
      end)

    assert length(@attacker_locations) == num_attackers
  end

  test "new/0 attackers are in correct place" do
    board = Board.new()

    attackers =
      Enum.map(@attacker_locations, fn location ->
        Board.cell_at(board, location)
      end)

    assert Enum.all?(attackers, &Board.attacker?/1)
  end

  test "new/0 correct number of defenders" do
    num_defenders =
      Enum.reduce(Board.new(), 0, fn row, acc ->
        acc + Enum.count(row, &Board.defender?/1)
      end)

    assert length(@defender_locations) == num_defenders
  end

  test "new/0 defenders are in correct place" do
    board = Board.new()

    defenders =
      Enum.map(@defender_locations, fn location ->
        Board.cell_at(board, location)
      end)

    assert Enum.all?(defenders, &Board.defender?/1)
  end

  test "new/0 correct number of hotspots" do
    num_hotspots =
      Enum.reduce(Board.new(), 0, fn row, acc ->
        acc + Enum.count(row, &Board.hotspot?/1)
      end)

    assert length(@hotspot_locations) == num_hotspots
  end

  test "new/0 hotspots are in correct place" do
    board = Board.new()

    hotspots =
      Enum.map(@hotspot_locations, fn location ->
        Board.cell_at(board, location)
      end)

    assert Enum.all?(hotspots, &Board.hotspot?/1)
  end

  test "new/0 king is in the correct place" do
    king = Board.cell_at(Board.new(), @king_location)

    assert Board.king?(king)
  end

  test "new/0 correct number of empty cells" do
    empty_spaces =
      Enum.reduce(Board.new(), 0, fn row, acc ->
        acc + Enum.count(row, &Board.empty?/1)
      end)

    assert @total_empty == empty_spaces
  end
end
