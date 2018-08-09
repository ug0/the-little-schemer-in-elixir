defmodule Schemer.ConsTheMagnificentTest do
  use ExUnit.Case
  doctest Schemer.ConsTheMagnificent

  import Schemer.ConsTheMagnificent, only: [rember: 2, firsts: 1, insertR: 3, insertL: 3, subst: 3, subst2: 4, multirember: 2, multiinsertR: 3, multiinsertL: 3]

  test "rember" do
    assert rember(:mint, [:lamb, :chops, :and, :mint, :jelly]) == [:lamb, :chops, :and, :jelly]
    assert rember(:mint, [:bacon, :lettuce, :and, :tomato]) == [:bacon, :lettuce, :and, :tomato]
  end

  test "firsts" do
    assert firsts([]) == []

    assert firsts([
             [:apple, :peach, :pumpkin],
             [:plum, :pear, :cherry],
             [:grape, :raisin, :pea],
             [:bean, :carrot, :eggplant]
           ]) == [:apple, :plum, :grape, :bean]
  end

  test "insertR" do
    assert insertR(
             :topping,
             :fudge,
             [:ice, :cream, :with, :for, :dessert]
           ) == [:ice, :cream, :with, :for, :dessert]

    assert insertR(
             :topping,
             :fudge,
             [:ice, :cream, :with, :fudge, :for, :dessert]
           ) == [:ice, :cream, :with, :fudge, :topping, :for, :dessert]
  end

  test "insertL" do
    assert insertL(
             :topping,
             :fudge,
             [:ice, :cream, :with, :fudge, :for, :dessert]
           ) == [:ice, :cream, :with, :topping, :fudge, :for, :dessert]

    assert insertL(
             :topping,
             :fudge,
             [:ice, :cream, :with, :for, :dessert]
           ) == [:ice, :cream, :with, :for, :dessert]
  end

  test "subst" do
    assert subst(
             :topping,
             :fudge,
             [:ice, :cream, :with, :fudge, :for, :dessert]
           ) == [:ice, :cream, :with, :topping, :for, :dessert]

    assert subst(
             :topping,
             :fudge,
             [:ice, :cream, :with, :for, :dessert]
           ) == [:ice, :cream, :with, :for, :dessert]
  end

  test "subst2" do
    assert subst2(
             :vanilla,
             :chocolate,
             :banana,
             [:banana, :ice, :cream, :with, :chocolate, :topping]
           ) == [:vanilla, :ice, :cream, :with, :chocolate, :topping]

    assert subst2(
             :vanilla,
             :chocolate,
             :banana,
             [:chocolate, :ice, :cream, :with, :banana, :topping]
           ) == [:vanilla, :ice, :cream, :with, :banana, :topping]

    assert subst2(
             :vanilla,
             :apple,
             :warm,
             [:chocolate, :ice, :cream, :with, :banana, :topping]
           ) == [:chocolate, :ice, :cream, :with, :banana, :topping]
  end

  test "multirember" do
    assert multirember(
      :cup,
      [:coffee, :cup, :tea, :cup, :and, :hick, :cup]
    ) == [:coffee, :tea, :and, :hick]

    assert multirember(
      :cup,
      [:coffee]
    ) == [:coffee]
  end

  test "multiinsertR" do
    assert multiinsertR(
      :new,
      :cup,
      [:coffee, :cup, :tea, :cup, :and, :hick, :cup]
    ) == [:coffee, :cup, :new, :tea, :cup, :new, :and, :hick, :cup, :new]

    assert multiinsertR(
      :new,
      :cup,
      [:coffee]
    ) == [:coffee]
  end

  test "multiinsertL" do
    assert multiinsertL(
      :new,
      :cup,
      [:coffee, :cup, :tea, :cup, :and, :hick, :cup]
    ) == [:coffee, :new, :cup, :tea, :new, :cup, :and, :hick, :new, :cup]

    assert multiinsertL(
      :new,
      :cup,
      [:coffee]
    ) == [:coffee]
  end
end
