defmodule Schemer.DoItAgainTest do
  use ExUnit.Case
  doctest Schemer.DoItAgain

  import Schemer.DoItAgain, only: [lat?: 1, member?: 2]

  test "lat?" do
    assert lat?([])
    assert lat?([1, 2, 3])
    refute lat?([[1, 2, 3], 4, 5, 6])
  end

  test "member?" do
    assert member?(:meat, [:and, :meat, :gravy])
    refute member?(:apple, [:and, :meat, :gravy])
  end
end
