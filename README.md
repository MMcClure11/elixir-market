# ElixirMarket Checkout System

A flexible checkout system for a small chain of supermarkets, built with Elixir.

## Overview

This project implements a checkout system that applies various pricing rules to
products in a shopping basket. The system is designed to be flexible, allowing
for easy addition and modification of pricing rules as business requirements
change.

## Problem Statement

You are the lead programmer for a small chain of supermarkets. You are required
to make a simple cashier function that adds products to a cart and displays the
total price.

### Products

| Product Code | Name         | Price  |
|--------------|--------------|--------|
| GR1          | Green tea    | £3.11  |
| SR1          | Strawberries | £5.00  |
| CF1          | Coffee       | £11.23 |

### Special Conditions

- **Buy-One-Get-One-Free**: When buying Green Tea (GR1), every second item is free.
- **Bulk Strawberry Discount**: When buying 3 or more Strawberries (SR1), the
 price drops to £4.50 per strawberry.
- **Bulk Coffee Discount**: When buying 3 or more Coffees (CF1), the price of
 all coffees drops to two-thirds of the original price.
- **Coffee-Strawberry Combo**: When buying 2 or more Coffees (CF1) and at least
 1 Strawberry (SR1), one strawberry gets a 50% discount.

### Requirements

- The checkout can scan items in any order.
- The pricing rules need to be flexible as they change frequently.

## Solution Architecture

The solution is built with a modular architecture that separates concerns and makes the system easy to extend:

1. **Product Module**: Defines product data and provides lookup functionality.
2. **Pricing Rules**: Each rule is implemented as a separate module with a common interface.
3. **Checkout Module**: Parses the basket and applies pricing rules to calculate the total.
4. **Interactive Basket**: Provides an interface for interacting with the checkout system.

### Key Design Decisions

- **Behaviour Pattern**: Used to define a consistent interface for all pricing rules.
- **Functional Approach**: Pure functions are used where possible for easier testing and reasoning.
- **Comprehensive Documentation**: Modules and functions are thoroughly documented.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/MMcClure11/elixir-market.git
   cd elixir_market
   ```

2. Fetch dependencies:
   ```bash
   mix deps.get
   ```

## Running Tests

Run all tests with:
```bash
mix test
```

### Test Cases from Requirements

The system passes all the required test cases:

1. **Basket**: GR1,SR1,GR1,GR1,CF1
   **Expected Total**: £22.45

2. **Basket**: GR1,GR1
   **Expected Total**: £3.11

3. **Basket**: SR1,SR1,GR1,SR1
   **Expected Total**: £16.61

4. **Basket**: GR1,CF1,SR1,CF1,CF1
   **Expected Total**: £30.57

You can run these specific test cases with:
```bash
mix test test/elixir_market_test.exs
```

## Using the Interactive Basket

The project includes an interactive basket module that can be used in an IEx session:

1. Start an IEx session:
   ```bash
   iex -S mix
   ```

2. Create a new basket:
   ```elixir
   alias ElixirMarket.InteractiveBasket, as: Basket
   basket = Basket.new()
   ```

3. List available products:
   ```elixir
   Basket.list_products()
   ```

4. Add items to the basket:
   ```elixir
   basket = Basket.add(basket, "GR1")
   basket = Basket.add(basket, "SR1")
   basket = Basket.add(basket, "CF1")
   ```

5. View the current basket:
   ```elixir
   Basket.show(basket)
   ```

6. Calculate the total:
   ```elixir
   Basket.total(basket)
   ```

7. Clear the basket:
   ```elixir
   basket = Basket.clear()
   ```

### Example Session

```elixir
iex> alias ElixirMarket.InteractiveBasket, as: Basket
iex> basket = Basket.new()
""

iex> Basket.list_products()
# Displays available products and pricing rules

iex> basket = Basket.add(basket, "GR1")
# Added: Green tea (GR1) - £3.11
# Current basket: GR1
# Current total: £3.11
"GR1"

iex> basket = Basket.add(basket, "GR1")
# Added: Green tea (GR1) - £3.11
# Current basket: GR1, GR1
# Current total: £3.11
"GR1,GR1"

iex> Basket.show(basket)
# Current basket: GR1, GR1
# Current total: £3.11
# 
# Items:
#   Green tea (GR1) x2 - £3.11 each
# 
# Applied pricing rules:
#   - Buy one get one free applied to Green tea
"GR1,GR1"
```

## Adding New Pricing Rules

To add a new pricing rule:

1. Create a new module that implements the ```ElixirMarket.PricingRule``` behaviour:
   ```elixir
   defmodule ElixirMarket.PricingRules.NewRule do
     @moduledoc """
     Documentation for the new rule
     """
     @behaviour ElixirMarket.PricingRule

     @impl true
     def apply(items) do
       # Rule implementation
       items
     end
   end
   ```

2. Add the new rule to the list in ```ElixirMarket.PricingRule.available_rules/0```:
   ```elixir
   def available_rules do
     [
       # Existing rules...
       ElixirMarket.PricingRules.NewRule
     ]
   end
   ```

## Project Structure

```
lib/
├── elixir_market/
│   ├── checkout.ex               # Checkout functionality
│   ├── interactive_basket.ex     # Interactive basket for IEx
│   ├── pricing_rule.ex           # Pricing rule behaviour
│   ├── pricing_rules/            # Individual pricing rules
│   │   ├── buy_one_get_one_free.ex
│   │   ├── bulk_strawberry_discount.ex
│   │   ├── bulk_coffee_discount.ex
│   └── product.ex                # Product definitions
test/
├── checkout_test.exs             # Checkout tests
├── interactive_basket_test.exs   # Interactive basket tests
└── pricing_rules/                # Pricing rule tests
    ├── buy_one_get_one_free_test.exs
    ├── bulk_strawberry_discount_test.exs
    ├── bulk_coffee_discount_test.exs
    ├── coffee_strawberry_combo_test.exs
    └── default_pricing_test.exs
```

## Design Principles

This project follows several key design principles:

1. **Single Responsibility Principle**: Each module has a single, well-defined responsibility.
2. **Open/Closed Principle**: The system is open for extension (new rules) but closed for modification.
3. **Dependency Inversion**: High-level modules don't depend on low-level modules; both depend on abstractions.
4. **Test-Driven Development**: Tests were written before implementation to guide the design.
5. **Functional Programming**: Pure functions and immutable data structures are used where possible.

## Conclusion

This checkout system demonstrates a flexible, extensible design that can easily
accommodate changing business requirements. The modular architecture and
separation of concerns make it easy to add new features or modify existing ones
without affecting the rest of the system.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
