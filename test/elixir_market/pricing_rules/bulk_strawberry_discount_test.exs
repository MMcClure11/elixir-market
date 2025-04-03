defmodule ElixirMarket.PricingRules.BulkStrawberryDiscountTest do
  use ExUnit.Case, async: true

  import ElixirMarket.TestHelpers, only: [random_price: 0]

  alias ElixirMarket.PricingRules.BulkStrawberryDiscount

  describe "apply/1" do
    test "returns an empty list when there are no items" do
      assert BulkStrawberryDiscount.apply([]) == []
    end

    test "returns an empty list when there are no strawberries" do
      items = [%{code: :CF1, name: "Coffee", price: random_price()}]
      assert BulkStrawberryDiscount.apply(items) == []
    end

    test "returns the correct items with final prices for 1 item" do
      price = random_price()
      items = [%{code: :SR1, name: "Strawberries", price: price}]
      expected_items = [%{code: :SR1, name: "Strawberries", price: price, final_price: price}]
      assert BulkStrawberryDiscount.apply(items) == expected_items
    end

    test "returns the correct items with final prices for 2 items" do
      price = random_price()

      items = [
        %{code: :SR1, name: "Strawberries", price: price},
        %{code: :SR1, name: "Strawberries", price: price}
      ]

      expected_items = [
        %{code: :SR1, name: "Strawberries", price: price, final_price: price},
        %{code: :SR1, name: "Strawberries", price: price, final_price: price}
      ]

      assert BulkStrawberryDiscount.apply(items) == expected_items
    end

    test "returns the correct items with final prices for 3 items" do
      price = random_price()

      items = [
        %{code: :SR1, name: "Strawberries", price: price},
        %{code: :SR1, name: "Strawberries", price: price},
        %{code: :SR1, name: "Strawberries", price: price}
      ]

      expected_items = [
        %{code: :SR1, name: "Strawberries", price: price, final_price: 4.50},
        %{code: :SR1, name: "Strawberries", price: price, final_price: 4.50},
        %{code: :SR1, name: "Strawberries", price: price, final_price: 4.50}
      ]

      assert BulkStrawberryDiscount.apply(items) == expected_items
    end

    test "returns the correct items with final prices for 4 items" do
      price = random_price()

      items = [
        %{code: :SR1, name: "Strawberries", price: price},
        %{code: :SR1, name: "Strawberries", price: price},
        %{code: :SR1, name: "Strawberries", price: price},
        %{code: :SR1, name: "Strawberries", price: price}
      ]

      expected_items = [
        %{code: :SR1, name: "Strawberries", price: price, final_price: 4.50},
        %{code: :SR1, name: "Strawberries", price: price, final_price: 4.50},
        %{code: :SR1, name: "Strawberries", price: price, final_price: 4.50},
        %{code: :SR1, name: "Strawberries", price: price, final_price: 4.50}
      ]

      assert BulkStrawberryDiscount.apply(items) == expected_items
    end
  end
end
