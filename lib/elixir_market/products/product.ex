defmodule ElixirMarket.Products.Product do
  @moduledoc """
  A struct for modeling a `ElixirMarket.Products.Product`.
  """

  @typedoc "Available product codes."
  @type code() :: :CF1 | :GR1 | :SR1

  @type t() :: %__MODULE__{
          code: code(),
          name: String.t(),
          price: pos_integer
        }

  @enforce_keys [:code, :name, :price]

  defstruct @enforce_keys
end
