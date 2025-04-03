defmodule ElixirMarket.PricingRules.BulkStrawberryDiscount do
  @moduledoc """
  Implements the bulk discount pricing rule for Strawberries (SR1).

  ## Rule Details

  When a customer buys Strawberry items:
  - Regular price (£5.00) applies when buying 1 or 2 strawberries
  - Discounted price (£4.50) applies when buying 3 or more strawberries
  - The discount applies to ALL strawberries in the basket when the threshold
  is met

  ## Examples

  - 1 Strawberry: £5.00
  - 2 Strawberries: £10.00 (2 × £5.00)
  - 3 Strawberries: £13.50 (3 × £4.50)
  - 4 Strawberries: £18.00 (4 × £4.50)

  ## Implementation

  The rule counts the number of Strawberry items and applies the appropriate
  price based on whether the count meets the bulk purchase threshold (3 or
  more).
  """
  @behaviour ElixirMarket.PricingRules.PricingRule

  @impl true
  def apply(items) do
    strawberries = Enum.filter(items, &(&1.code == :SR1))

    case length(strawberries) do
      n when n >= 3 ->
        Enum.map(strawberries, fn item -> Map.put(item, :final_price, 4.50) end)

      _ ->
        Enum.map(strawberries, fn item -> Map.put(item, :final_price, item.price) end)
    end
  end
end
