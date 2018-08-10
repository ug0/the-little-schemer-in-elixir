defmodule Schemer.NumbersGamesTest do
  use ExUnit.Case
  doctest Schemer.NumbersGames

  import Kernel, except: [div: 2, length: 1]
  import Schemer.NumbersGames

  test "add" do
    assert add(3, 5) == 8
  end

  test "sub" do
    assert sub(5, 2) == 3
  end

  test "addtup" do
    assert addtup([1, 2, 3]) == 6
  end

  test "times" do
    assert times(2, 3) == 6
    assert times(2, 0) == 0
  end

  test "tupadd" do
    assert tupadd([3, 6, 9, 11, 4], [8, 5, 2, 0, 7]) == [11, 11, 11, 11, 11]
    assert tupadd([3, 6, 9, 11, 4], [8, 5, 2]) == [11, 11, 11, 11, 4]
    assert tupadd([3, 6, 9], [8, 5, 2, 0, 7]) == [11, 11, 11, 0, 7]
  end

  test "greaterthan" do
    refute greaterthan?(1, 5)
    refute greaterthan?(1, 1)
    assert greaterthan?(11, 5)
  end

  test "lessthan" do
    assert lessthan?(1, 5)
    refute lessthan?(1, 1)
    refute lessthan?(11, 5)
  end

  test "equalnum" do
    assert equalnum?(1, 1)
    refute equalnum?(1, 2)
  end

  test "power" do
    assert power(1, 1) == 1
    assert power(2, 3) == 8
    assert power(5, 3) == 125
  end

  test "div" do
    assert div(15, 4) == 3
    assert div(3, 4) == 0
  end

  test "length" do
    assert length([]) == 0
    assert length([1, 2, 3]) == 3
  end

  test "pick" do
    assert pick(2, [:a, :b, :c]) == :b
  end

  test "rempick" do
    assert rempick(3, [:a, :b, :c, :d, :e]) == [:a, :b, :d, :e]
  end

  test "non_nums" do
    assert non_nums([5, :pears, 6, :prunes, 9, :dates]) == [:pears, :prunes, :dates]
  end

  test "all_nums" do
    assert all_nums([5, :pears, 6, :prunes, 9, :dates]) == [5, 6, 9]
  end

  test "eqan" do
    assert eqan?(1, 1)
    refute eqan?(1, 5)
    assert eqan?(:a, :a)
    refute eqan?(:a, :b)
    refute eqan?(1, :a)
  end

  test "occur" do
    assert occur(:a, []) == 0
    assert occur(:a, [:b, :c, :d]) == 0
    assert occur(:a, [:a, :b, :c, :a, :d]) == 2
  end

  test "one?" do
    refute one?(2)
    assert one?(1)
  end
end
