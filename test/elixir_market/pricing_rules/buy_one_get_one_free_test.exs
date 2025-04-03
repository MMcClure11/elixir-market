defmodule ElixirMarket.PricingRules.BuyOneGetOneFreeTest do
  use ExUnit.Case, async: true

  import ElixirMarket.TestHelpers, only: [random_price: 0]

  alias ElixirMarket.PricingRules.BuyOneGetOneFree

  describe "apply/1" do
    test "returns an empty list when there are no items" do
      assert BuyOneGetOneFree.apply([]) == []
    end

    test "returns an empty list when there are no green teas" do
      price = random_price()
      items = [%{code: :CF1, name: "Coffee", price: price}]
      assert BuyOneGetOneFree.apply(items) == []
    end

    test "returns the correct items with final prices for 1 item" do
      price = random_price()
      items = [%{code: :GR1, name: "Green Tea", price: price}]
      expected_items = [%{code: :GR1, name: "Green Tea", price: price, final_price: price}]
      assert BuyOneGetOneFree.apply(items) == expected_items
    end

    test "returns the correct items with final prices for 2 items" do
      price = random_price()

      items = [
        %{code: :GR1, name: "Green Tea", price: price},
        %{code: :GR1, name: "Green Tea", price: price}
      ]

      expected_items = [
        %{code: :GR1, name: "Green Tea", price: price, final_price: price},
        %{code: :GR1, name: "Green Tea", price: price, final_price: 0}
      ]

      assert BuyOneGetOneFree.apply(items) == expected_items
    end

    test "returns the correct items with final prices for 3 items" do
      price = random_price()

      items = [
        %{code: :GR1, name: "Green Tea", price: price},
        %{code: :GR1, name: "Green Tea", price: price},
        %{code: :GR1, name: "Green Tea", price: price}
      ]

      expected_items = [
        %{code: :GR1, name: "Green Tea", price: price, final_price: price},
        %{code: :GR1, name: "Green Tea", price: price, final_price: price},
        %{code: :GR1, name: "Green Tea", price: price, final_price: 0}
      ]

      assert BuyOneGetOneFree.apply(items) == expected_items
    end

    test "returns the correct items with final prices for 4 items" do
      price = random_price()

      items = [
        %{code: :GR1, name: "Green Tea", price: price},
        %{code: :GR1, name: "Green Tea", price: price},
        %{code: :GR1, name: "Green Tea", price: price},
        %{code: :GR1, name: "Green Tea", price: price}
      ]

      expected_items = [
        %{code: :GR1, name: "Green Tea", price: price, final_price: price},
        %{code: :GR1, name: "Green Tea", price: price, final_price: price},
        %{code: :GR1, name: "Green Tea", price: price, final_price: 0},
        %{code: :GR1, name: "Green Tea", price: price, final_price: 0}
      ]

      assert BuyOneGetOneFree.apply(items) == expected_items
    end
  end
end
