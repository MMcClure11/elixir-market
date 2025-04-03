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

  @doc """
  Returns a product by its code.
  If the product is not found, returns `nil`.

  ## Examples

    iex> ElixirMarket.Products.get_product_by_code(:CF1)
    %Product{code: :CF1, name: "Coffee", price: 11.23}
  """
  @spec get_product_by_code(atom | String.t()) :: Product.t() | nil
  def get_product_by_code(code) when is_binary(code) do
    try do
      code |> String.to_existing_atom() |> get_product_by_code()
    rescue
      ArgumentError -> nil
    end
  end

  def get_product_by_code(code) when is_atom(code) do
    Enum.find(@products, fn product -> product.code == code end)
  end
end
