defmodule ElixirMarket.ProductsTest do
  use ExUnit.Case, async: true
  alias ElixirMarket.Products
  alias ElixirMarket.Products.Product

  describe "list_products/0" do
    test "returns a list of products" do
      expected_products = [
        %Product{code: :CF1, name: "Coffee", price: 11.23},
        %Product{code: :GR1, name: "Green Tea", price: 3.11},
        %Product{code: :SR1, name: "Strawberries", price: 5.00}
      ]

      assert Products.list_products() == expected_products
    end
  end

  describe "get_product_by_code/1" do
    test "returns the product for a valid code when given string" do
      assert Products.get_product_by_code("CF1") == %Product{
               code: :CF1,
               name: "Coffee",
               price: 11.23
             }
    end

    test "returns the product for a valid code when given atom" do
      assert Products.get_product_by_code(:CF1) == %Product{
               code: :CF1,
               name: "Coffee",
               price: 11.23
             }
    end

    test "returns nil for an invalid atom code" do
      assert Products.get_product_by_code(:INVALID_CODE) == nil
    end

    test "returns nil for an invalid string code" do
      assert Products.get_product_by_code("K9U") == nil
    end
  end
end
