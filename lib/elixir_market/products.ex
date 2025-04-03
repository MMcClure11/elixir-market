defmodule ElixirMarket.Products do
  @moduledoc """
  The Products context.
  """

  alias ElixirMarket.Products.Product

  @products [
    %Product{code: :CF1, name: "Coffee", price: 11.23},
    %Product{code: :GR1, name: "Green Tea", price: 3.11},
    %Product{code: :SR1, name: "Strawberries", price: 5.00}
  ]

  @doc """
  Returns a list of products.

  ## Examples

      iex> ElixirMarket.Products.list_products()
      [
        %Product{code: :CF1, name: "Coffee", price: 11.23},
        %Product{code: :GR1, name: "Green Tea", price: 3.11},
        %Product{code: :SR1, name: "Strawberries", price: 5.00}
      ]
  """
  @spec list_products() :: any
  def list_products, do: @products
end
