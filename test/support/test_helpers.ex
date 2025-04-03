defmodule ElixirMarket.TestHelpers do
  @moduledoc """
  A module for test helpers.
  """

  @doc """
  Generates a random price value between 0.00 and 50.00.

  ## Examples

      iex> random_price()
      23.45

      iex> random_price()
      7.82

  Returns a float representing a random price with 2 decimal places, with a
  maximum value of 50.00.
  """
  @spec random_price() :: float()
  def random_price do
    :rand.uniform(5000) / 100
  end
end
