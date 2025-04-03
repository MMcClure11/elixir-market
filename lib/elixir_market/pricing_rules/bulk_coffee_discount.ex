defmodule ElixirMarket.PricingRules.BulkCoffeeDiscount do
  @moduledoc """
  Implements the bulk discount pricing rule for Coffee (CF1).

  ## Rule Details

  When a customer buys Coffee items:
  - Regular price (£11.23) applies when buying 1 or 2 coffees
  - Discounted price (2/3 of regular price = £7.49) applies when buying 3 or
  more coffees
  - The discount applies to ALL coffees in the basket when the threshold is met

  ## Examples

  - 1 Coffee: £11.23
  - 2 Coffees: £22.46 (2 × £11.23)
  - 3 Coffees: £22.46 (3 × £7.49)
  - 4 Coffees: £29.95 (4 × £7.49)

  ## Implementation

  The rule counts the number of Coffee items and applies the appropriate price
  based on whether the count meets the bulk purchase threshold (3 or more).
  When the threshold is met, the price is reduced to 2/3 of the original price.
  """
  @behaviour ElixirMarket.PricingRules.PricingRule

  @impl true
  def apply(items) do
    coffees = Enum.filter(items, &(&1.code == :CF1))

    case length(coffees) do
      n when n >= 3 ->
        Enum.map(coffees, fn item -> Map.put(item, :final_price, item.price * 2 / 3) end)

      _ ->
        Enum.map(coffees, fn item -> Map.put(item, :final_price, item.price) end)
    end
  end
end
