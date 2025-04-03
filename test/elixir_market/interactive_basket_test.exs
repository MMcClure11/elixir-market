defmodule ElixirMarket.InteractiveBasketTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias ElixirMarket.InteractiveBasket, as: Basket

  describe "new/0" do
    test "creates an empty basket" do
      assert Basket.new() == ""
    end
  end

  describe "add/2" do
    test "adds a valid product to the basket" do
      basket = Basket.new()
      output = capture_io(fn -> assert Basket.add(basket, "GR1") == "GR1" end)
      assert output =~ "Added: Green Tea (GR1)"
      assert output =~ "Current basket: GR1"
      assert output =~ "Current total: £3.11"
    end

    test "handles invalid product codes" do
      basket = Basket.new()
      output = capture_io(fn -> assert Basket.add(basket, "XX1") == "" end)
      assert output =~ "Product not found: XX1"
      assert output =~ "Available products:"
    end
  end

  describe "total/1" do
    test "calculates the total for an empty basket" do
      basket = Basket.new()
      output = capture_io(fn -> assert Basket.total(basket) == "" end)
      assert output =~ "Total: £"
    end

    test "calculates the total for a basket with one item" do
      basket = "GR1"
      output = capture_io(fn -> assert Basket.total(basket) == "GR1" end)
      assert output =~ "Total: £3.11"
    end

    test "calculates the total for a basket with multiple items" do
      basket = "GR1,SR1,CF1"
      output = capture_io(fn -> assert Basket.total(basket) == "GR1,SR1,CF1" end)
      assert output =~ "Total: £19.34"
    end

    test "applies buy-one-get-one-free discount for green tea" do
      basket = "GR1,GR1"
      output = capture_io(fn -> assert Basket.total(basket) == "GR1,GR1" end)
      assert output =~ "Total: £3.11"
    end

    test "applies bulk discount for strawberries" do
      basket = "SR1,SR1,SR1"
      output = capture_io(fn -> assert Basket.total(basket) == "SR1,SR1,SR1" end)
      assert output =~ "Total: £13.5"
    end

    test "applies bulk discount for coffee" do
      basket = "CF1,CF1,CF1"
      output = capture_io(fn -> assert Basket.total(basket) == "CF1,CF1,CF1" end)
      assert output =~ "Total: £22.46"
    end
  end

  describe "show/1" do
    test "displays message for empty basket" do
      basket = Basket.new()
      output = capture_io(fn -> assert Basket.show(basket) == "" end)
      assert output =~ "Basket is empty"
    end

    test "displays basket contents and total" do
      basket = "GR1,SR1,CF1"
      output = capture_io(fn -> assert Basket.show(basket) == basket end)
      assert output =~ "Current basket: GR1,SR1,CF1"
      assert output =~ "Current total: £19.34"
      assert output =~ "Green Tea (GR1) x1 - £3.11 each"
      assert output =~ "Strawberries (SR1) x1"
      assert output =~ "Coffee (CF1) x1"
    end

    test "displays applied pricing rules" do
      basket = "GR1,GR1,SR1,SR1,SR1,CF1,CF1,CF1"
      output = capture_io(fn -> assert Basket.show(basket) == basket end)
      assert output =~ "Buy one get one free applied to Green tea"
      assert output =~ "Bulk discount applied to Strawberries"
      assert output =~ "Bulk discount applied to Coffee"
    end
  end

  describe "clear/0" do
    test "returns an empty basket" do
      output = capture_io(fn -> assert Basket.clear() == "" end)
      assert output =~ "Basket cleared"
    end
  end

  describe "list_products/0" do
    test "displays all available products and pricing rules" do
      output = capture_io(fn -> Basket.list_products() end)
      assert output =~ "Available products:"
      assert output =~ "Green Tea (GR1) - £3.11"
      assert output =~ "Strawberries (SR1) - £5.0"
      assert output =~ "Coffee (CF1) - £11.23"
      assert output =~ "Pricing rules:"
      assert output =~ "Buy one get one free on Green tea"
      assert output =~ "Bulk discount on Strawberries"
      assert output =~ "Bulk discount on Coffee"
    end
  end

  # Integration tests

  test "full shopping experience" do
    output =
      capture_io(fn ->
        basket = Basket.new()
        basket = Basket.add(basket, "GR1")
        basket = Basket.add(basket, "SR1")
        basket = Basket.add(basket, "GR1")
        basket = Basket.add(basket, "GR1")
        basket = Basket.add(basket, "CF1")
        Basket.show(basket)
        Basket.clear()
      end)

    assert output =~ "Current total: £22.45"
    assert output =~ "Buy one get one free applied to Green tea"
    assert output =~ "Basket cleared"
  end
end
