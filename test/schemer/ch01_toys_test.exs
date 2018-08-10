defmodule Schemer.ToysTest do
  use ExUnit.Case
  doctest Schemer.Toys

  import Schemer.Toys

  test "car" do
    assert car([1, 2, 3]) == 1
    assert car([[1, 2, 3], 4, 5, 6]) == [1, 2, 3]
  end

  test "cdr" do
    assert cdr([1, 2, 3]) == [2, 3]
    assert cdr([1]) == []
  end

  test "cons" do
    assert cons(1, [2, 3, 4]) == [1, 2, 3, 4]
    assert cons([1, 2, 3], [4, 5, 6]) == [[1, 2, 3], 4, 5, 6]
    assert cons([1, 2, [3]], []) == [[1, 2, [3]]]
  end

  test "null?" do
    assert null?([])
    refute null?([1])
  end

  test "eq?" do
    assert eq?(:a, :a)
    refute eq?(:a, :b)
  end
end
