defmodule ElixirMarket.PricingRules.BulkCoffeeDiscountTest do
  use ExUnit.Case, async: true

  import ElixirMarket.TestHelpers, only: [random_price: 0]

  alias ElixirMarket.PricingRules.BulkCoffeeDiscount

  describe "apply/1" do
    test "returns an empty list when there are no items" do
      assert BulkCoffeeDiscount.apply([]) == []
    end

    test "returns an empty list when there is no coffee" do
      items = [%{code: :SR1, name: "Strawberries", price: random_price()}]
      assert BulkCoffeeDiscount.apply(items) == []
    end

    test "returns the correct items with final prices for 1 item" do
      price = random_price()
      items = [%{code: :CF1, name: "Coffee", price: price}]
      expected_items = [%{code: :CF1, name: "Coffee", price: price, final_price: price}]
      assert BulkCoffeeDiscount.apply(items) == expected_items
    end

    test "returns the correct items with final prices for 2 items" do
      price = random_price()

      items = [
        %{code: :CF1, name: "Coffee", price: price},
        %{code: :CF1, name: "Coffee", price: price}
      ]

      expected_items = [
        %{code: :CF1, name: "Coffee", price: price, final_price: price},
        %{code: :CF1, name: "Coffee", price: price, final_price: price}
      ]

      assert BulkCoffeeDiscount.apply(items) == expected_items
    end

    test "returns the correct items with final prices for 3 items" do
      price = random_price()
      final_price = price * 2 / 3

      items = [
        %{code: :CF1, name: "Coffee", price: price},
        %{code: :CF1, name: "Coffee", price: price},
        %{code: :CF1, name: "Coffee", price: price}
      ]

      expected_items = [
        %{code: :CF1, name: "Coffee", price: price, final_price: final_price},
        %{code: :CF1, name: "Coffee", price: price, final_price: final_price},
        %{code: :CF1, name: "Coffee", price: price, final_price: final_price}
      ]

      assert BulkCoffeeDiscount.apply(items) == expected_items
    end

    test "returns the correct items with final prices for 4 items" do
      price = random_price()
      final_price = price * 2 / 3

      items = [
        %{code: :CF1, name: "Coffee", price: price},
        %{code: :CF1, name: "Coffee", price: price},
        %{code: :CF1, name: "Coffee", price: price},
        %{code: :CF1, name: "Coffee", price: price}
      ]

      expected_items = [
        %{code: :CF1, name: "Coffee", price: price, final_price: final_price},
        %{code: :CF1, name: "Coffee", price: price, final_price: final_price},
        %{code: :CF1, name: "Coffee", price: price, final_price: final_price},
        %{code: :CF1, name: "Coffee", price: price, final_price: final_price}
      ]

      assert BulkCoffeeDiscount.apply(items) == expected_items
    end
  end
end
