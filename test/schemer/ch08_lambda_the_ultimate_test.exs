defmodule Schemer.LambdaTest do
  use ExUnit.Case
  doctest Schemer.Lambda

  use Schemer.Primitive
  import Schemer.Lambda
  import Schemer.NumbersGames, only: [length: 1]
  import Schemer.FullOfStars, only: [equal?: 2]

  test "rember_f" do
    assert rember_f(&eq?/2).(5, [6, 2, 5, 3]) == [6, 2, 3]
    assert rember_f(&eq?/2).(:jelly, [:jelly, :beans, :are, :good]) == [:beans, :are, :good]
    assert rember_f(&equal?/2).([:pop, :corn], [
      :lemonade,
      [:pop, :corn],
      :and,
      [:cake]
    ]) == [:lemonade, :and, [:cake]]
  end

  test "insertL_f" do
    assert insertL_f(&eq?/2).(
             :topping,
             :fudge,
             [:ice, :cream, :with, :fudge, :for, :dessert]
           ) == [:ice, :cream, :with, :topping, :fudge, :for, :dessert]

    assert insertL_f(&eq?/2).(
             :topping,
             :fudge,
             [:ice, :cream, :with, :for, :dessert]
           ) == [:ice, :cream, :with, :for, :dessert]
    assert insertL_f(&equal?/2).(
            :fudge,
            [:topping, :fudge],
            [:ice, :cream, :with, [:topping, :fudge], :for, :dessert]
           ) == [:ice, :cream, :with, :fudge, [:topping, :fudge], :for, :dessert]
  end

  test "insertR_f" do
    assert insertR_f(&eq?/2).(
             :topping,
             :fudge,
             [:ice, :cream, :with, :fudge, :for, :dessert]
           ) == [:ice, :cream, :with, :fudge, :topping, :for, :dessert]

    assert insertR_f(&eq?/2).(
             :topping,
             :fudge,
             [:ice, :cream, :with, :for, :dessert]
           ) == [:ice, :cream, :with, :for, :dessert]
    assert insertR_f(&equal?/2).(
            :fudge,
            [:topping, :fudge],
            [:ice, :cream, :with, [:topping, :fudge], :for, :dessert]
           ) == [:ice, :cream, :with, [:topping, :fudge], :fudge, :for, :dessert]
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

  test "insertR" do
    assert insertR(
             :topping,
             :fudge,
             [:ice, :cream, :with, :fudge, :for, :dessert]
           ) == [:ice, :cream, :with, :fudge, :topping, :for, :dessert]

    assert insertR(
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

  test "value" do
    assert value(13) == 13
    assert value([1, :+, 3]) == 4
    assert value([1, :+, [3, :^, 4]]) == 82
  end

  test "multirember_f" do
    assert multirember_f(&eq?/2).(
      :cup,
      [:coffee, :cup, :tea, :cup, :and, :hick, :cup]
    ) == [:coffee, :tea, :and, :hick]

    assert multirember_f(&equal?/2).(
      [:cup, :coffee],
      [:coffee, :cup, :coffee, [:cup, :coffee], :tea, :cup, :and, [:cup, :coffee], :hick, :cup]
    ) == [:coffee, :cup, :coffee, :tea, :cup, :and, :hick, :cup]
  end

  test "multiremberT" do
    assert multiremberT(&eq?(&1, :tuna), [:shrimp, :salad, :tuna, :salad, :and, :tuna]) == [:shrimp, :salad, :salad, :and]
  end

  test "multirember_and_co" do
    a_friend = fn _newlat, seen -> null?(seen) end

    assert multirember_and_co(:tuna, [], a_friend)
    refute multirember_and_co(:tuna, [:tuna], a_friend)
    refute multirember_and_co(:tuna, [:and, :tuna], a_friend)
    assert multirember_and_co(:tuna, [:strawberries, :tuna, :and, :swordfish], fn newlat, _seen -> length(newlat) end) == 3
  end

  test "multiinsertLR" do
    assert multiinsertLR(
      :new,
      :cup,
      :coffee,
      [:coffee, :cup, :tea, :cup, :coffee, :and, :hick, :cup]
    ) == [:coffee, :new, :new, :cup, :tea, :new, :cup, :coffee, :new, :and, :hick, :new, :cup]
  end

  test "multiinsertLR_and_co" do
    assert multiinsertLR_and_co(
      :new,
      :cup,
      :coffee,
      [:coffee, :cup, :tea, :cup, :coffee, :and, :hick, :cup],
      fn (newlat, cl, cr) -> [newlat, cl, cr] end
    ) == [[:coffee, :new, :new, :cup, :tea, :new, :cup, :coffee, :new, :and, :hick, :new, :cup], 3, 2]

    assert multiinsertLR_and_co(:salty, :fish, :chips, [
      :chips, :and, :fish, :or, :fish, :and, :chips
    ], fn newlat, cl, cr -> [newlat, cl, cr] end) == [
      [:chips, :salty, :and, :salty, :fish, :or, :salty, :fish, :and, :chips, :salty],
      2,
      2
    ]
  end

  test "evens_only_star" do
    assert evens_only_star([
      [9, 1, 2, 8], 3, 10, [[9, 9], 7, 6], 2
    ]) == [[2, 8], 10, [[], 6], 2]
  end

  test "evens_only_star_and_co" do
    assert evens_only_star_and_co([
      [9, 1, 2, 8], 3, 10, [[9, 9], 7, 6], 2
    ], fn newl, p, s -> [newl, p, s] end) == [[[2, 8], 10, [[], 6], 2], 1920, 38]
  end
end
