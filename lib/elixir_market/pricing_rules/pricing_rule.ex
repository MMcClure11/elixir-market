defmodule ElixirMarket.PricingRules.PricingRule do
  @moduledoc """
  Defines the behaviour for pricing rules in the ElixirMarket system.

  Pricing rules are responsible for calculating the price of products based on
  specific conditions. Each rule should implement the ```apply/2``` callback,
  which takes the list of items, and returns a list containing the calculated
  priced items.

  ## Adding New Rules

  To add a new pricing rule:
  1. Create a new module that implements the ```ElixirMarket.PricingRule``` behaviour
  2. Implement the ```apply/2``` callback
  3. Add the module to the list returned by ```available_rules/0```
  """
  alias ElixirMarket.Products.Product

  @doc """
  Applies the pricing rule to the given items.

  ## Parameters

  - ```original_items```: The list of all items in the basket

  ## Returns

  A list of items with the final price calculated for each item based on the
  rule.
  """
  @callback apply(list(Product.t())) :: list()

  @doc """
  Returns a list of all available pricing rules.
  """
  @spec available_rules() :: list(module())
  def available_rules do
    [
      ElixirMarket.PricingRules.BuyOneGetOneFree,
      ElixirMarket.PricingRules.BulkCoffeeDiscount,
      ElixirMarket.PricingRules.BulkStrawberryDiscount
    ]
  end
end
