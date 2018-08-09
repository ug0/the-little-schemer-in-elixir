defmodule SchemerTest do
  use ExUnit.Case
  doctest Schemer

  test "greets the world" do
    assert Schemer.hello() == :world
  end
end
