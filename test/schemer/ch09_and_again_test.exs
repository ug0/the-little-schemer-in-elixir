defmodule Schemer.AndAgainTest do
  use ExUnit.Case
  doctest Schemer.AndAgain

  use Schemer.Primitive
  import Schemer.NumbersGames, only: [length: 1]
  import Schemer.AndAgain

  test "looking" do
    assert looking(:caviar, [6, 2, 4, :caviar, 5, 7, 3])
    refute looking(:caviar, [6, 2, :grits, :caviar, 5, 7, 3])
  end

  test "shift" do
    assert shift([[:a, :b], :c]) == [:a, [:b, :c]]
    assert shift([[:a, :b], [:c, :d]]) == [:a, [:b, [:c, :d]]]
  end
end
