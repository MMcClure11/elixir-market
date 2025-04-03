defmodule ElixirMarket.Checkout do
  @moduledoc """
  Provides functionality for calculating the total price of a shopping basket.

  The Checkout module is responsible for:
  1. Parsing the basket input
  2. Applying pricing rules to calculate the total price
  3. Formatting the result

  It works with the ```ElixirMarket.PricingRule``` system to apply various
  discount and special pricing rules to the basket items.
  """
  alias ElixirMarket.Products
  alias ElixirMarket.PricingRules.PricingRule

  @doc """
  Calculates the total price of a basket.

  ## Parameters

  - ```basket```: A string of comma-separated product codes

  ## Returns

  The total price of the basket after applying all pricing rules, rounded to 2
  decimal places.

  ## Examples

      iex> ElixirMarket.Checkout.calculate_total("GR1,SR1,GR1,GR1,CF1")
      22.45

      iex> ElixirMarket.Checkout.calculate_total(["GR1", "GR1"])
      3.11
  """
  @spec calculate_total(String.t() | list()) :: float()
  def calculate_total(basket) do
    basket
    |> parse_basket()
    |> apply_pricing_rules()
    |> calculate_price()
    |> then(&Float.round(1.0 * &1, 2))
  end

  @doc """
  Parses a basket input into a list of product structs.

  ## Parameters

  - ```basket```: A string of comma-separated product codes

  ## Returns

  A list of product structs.
  """
  @spec parse_basket(String.t() | list()) :: list()
  def parse_basket(basket) when is_binary(basket) do
    basket
    |> String.split(",", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Products.get_product_by_code/1)
  end

  @spec apply_pricing_rules(list()) :: list()
  defp apply_pricing_rules(items) do
    Enum.map(PricingRule.available_rules(), fn rule ->
      rule.apply(items)
    end)
    |> List.flatten()
  end

  @spec calculate_price(list()) :: float()
  defp calculate_price(priced_items) do
    Enum.reduce(priced_items, 0, fn item, total ->
      total + item.final_price
    end)
  end
end
