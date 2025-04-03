defmodule ElixirMarket.CheckoutTest do
  use ExUnit.Case, async: true
  alias ElixirMarket.Checkout
  alias ElixirMarket.Products.Product

  describe "parse_basket/1" do
    test "returns for string" do
      basket = "GR1,SR1,CF1"

      assert [%Product{code: :GR1}, %Product{code: :SR1}, %Product{code: :CF1}] =
               Checkout.parse_basket(basket)
    end
  end

  describe "calculate_total/1" do
    test "for empty basket" do
      assert Checkout.calculate_total("") == 0.0
    end

    test "for single item" do
      assert Checkout.calculate_total("GR1") == 3.11
    end

    # Test cases from the requirements
    test "for basket: GR1,SR1,GR1,GR1,CF1" do
      assert Checkout.calculate_total("GR1,SR1,GR1,GR1,CF1") == 22.45
    end

    test "for basket: GR1,GR1" do
      assert Checkout.calculate_total("GR1,GR1") == 3.11
    end

    test "for basket: SR1,SR1,GR1,SR1" do
      assert Checkout.calculate_total("SR1,SR1,GR1,SR1") == 16.61
    end

    test "for basket: GR1,CF1,SR1,CF1,CF1" do
      assert Checkout.calculate_total("GR1,CF1,SR1,CF1,CF1") == 30.57
    end
  end
end
