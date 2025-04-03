defmodule ElixirMarket.PricingRules.BuyOneGetOneFree do
  @moduledoc """
  Implements the "Buy One Get One Free" pricing rule for Green Tea (GR1).

  ## Rule Details

  When a customer buys Green Tea items:
  - For every 2 items, they only pay for 1
  - The free item is always the second one in each pair

  ## Examples

  - 1 Green Tea: Pay for 1 (£3.11)
  - 2 Green Teas: Pay for 1 (£3.11)
  - 3 Green Teas: Pay for 2 (£6.22)
  - 4 Green Teas: Pay for 2 (£6.22)

  ## Implementation

  The rule counts the number of Green Tea items, calculates how many should be paid for
  (ceiling of count/2), and applies the regular price to that many items.
  """
  @behaviour ElixirMarket.PricingRules.PricingRule

  @impl true
  def apply(items) do
    green_teas = Enum.filter(items, &(&1.code == :GR1))

    case length(green_teas) do
      0 ->
        []

      n ->
        free_count = div(n, 2)
        paid_count = n - free_count

        green_teas
        |> Enum.take(paid_count)
        |> Enum.map(fn item -> Map.put(item, :final_price, item.price) end)
        |> Enum.concat(
          green_teas
          |> Enum.drop(paid_count)
          |> Enum.map(fn item -> Map.put(item, :final_price, 0) end)
        )
    end
  end
end
