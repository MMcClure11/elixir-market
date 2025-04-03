defmodule ElixirMarket.InteractiveBasket do
  @moduledoc """
  A simple interactive basket for use in IEx sessions.

  Example usage:

      iex> alias ElixirMarket.InteractiveBasket, as: Basket
      iex> basket = Basket.new()
      iex> basket = Basket.add(basket, "GR1")
      iex> basket = Basket.add(basket, "SR1")
      iex> Basket.total(basket)
  """

  alias ElixirMarket.Products
  alias ElixirMarket.Checkout

  @doc """
  Creates a new empty basket.
  """
  @spec new() :: String.t()
  def new, do: ""

  @doc """
  Adds a product to the basket by its code and returns the updated basket.
  Also prints the current basket contents and total.
  """
  @spec add(String.t(), String.t()) :: String.t()
  def add(basket, product_code) do
    product = Products.get_product_by_code(product_code)

    if product do
      updated_basket = product_code <> "," <> basket
      total = Checkout.calculate_total(updated_basket)

      IO.puts("\nAdded: #{product.name} (#{product_code}) - £#{product.price})")

      trimmed_basket = updated_basket |> String.trim_trailing(",")
      IO.puts("Current basket: #{trimmed_basket}")
      IO.puts("Current total: £#{total}")

      trimmed_basket
    else
      IO.puts("\nProduct not found: #{product_code}")
      IO.puts("Available products: #{available_products()}")
      basket
    end
  end

  @doc """
  Calculates and returns the total price of the basket.
  """
  @spec total(String.t()) :: String.t()
  def total(basket) do
    IO.puts("\nTotal: £#{Checkout.calculate_total(basket)}\n")
    basket
  end

  @doc """
  Displays the current basket contents and total.
  """
  @spec show(String.t()) :: String.t()
  def show(basket) do
    if basket == "" do
      IO.puts("\nBasket is empty")
    else
      total = Checkout.calculate_total(basket)

      IO.puts("\nCurrent basket: #{basket}")
      IO.puts("Current total: £#{total}")

      # Show individual items with prices
      IO.puts("\nItems:")

      basket
      |> String.split(",", trim: true)
      |> Enum.group_by(& &1)
      |> Enum.each(fn {code, occurrences} ->
        product = Products.get_product_by_code(code)
        count = length(occurrences)

        IO.puts("  #{product.name} (#{code}) x#{count} - £#{product.price} each")
      end)

      # Show applied discounts
      IO.puts("\nApplied pricing rules:")
      show_applied_rules(basket)
    end

    basket
  end

  @doc """
  Clears the basket and returns an empty one.
  """
  @spec clear() :: String.t()
  def clear do
    IO.puts("\nBasket cleared")
    ""
  end

  @doc """
  Lists all available products.
  """
  @spec list_products() :: :ok
  def list_products do
    IO.puts("\nAvailable products:")

    Products.list_products()
    |> Enum.each(fn product ->
      IO.puts("  #{product.name} (#{product.code}) - £#{product.price})")
    end)

    IO.puts("\nPricing rules:")
    IO.puts("  - Buy one get one free on Green tea (GR1)")
    IO.puts("  - Bulk discount on Strawberries (SR1): £4.50 each when buying 3 or more")
    IO.puts("  - Bulk discount on Coffee (CF1): 2/3 price when buying 3 or more")
  end

  @spec available_products() :: String.t()
  defp available_products do
    Products.list_products()
    |> Enum.map(& &1.code)
    |> Enum.join(", ")
  end

  @spec show_applied_rules(String.t()) :: :ok
  defp show_applied_rules(basket) do
    basket = String.split(basket, ",", trim: true)
    items = Enum.map(basket, &Products.get_product_by_code/1)
    grouped_items = Enum.group_by(items, & &1.code)

    # Check for GR1 BOGO
    if Map.has_key?(grouped_items, :GR1) && length(Map.get(grouped_items, :GR1)) >= 2 do
      IO.puts("  - Buy one get one free applied to Green tea")
    end

    # Check for SR1 bulk discount
    if Map.has_key?(grouped_items, :SR1) && length(Map.get(grouped_items, :SR1)) >= 3 do
      IO.puts("  - Bulk discount applied to Strawberries")
    end

    # Check for CF1 bulk discount
    if Map.has_key?(grouped_items, :CF1) && length(Map.get(grouped_items, :CF1)) >= 3 do
      IO.puts("  - Bulk discount applied to Coffee")
    end
  end
end
