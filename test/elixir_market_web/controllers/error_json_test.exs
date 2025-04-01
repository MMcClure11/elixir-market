defmodule ElixirMarketWeb.ErrorJSONTest do
  use ElixirMarketWeb.ConnCase, async: true

  test "renders 404" do
    assert ElixirMarketWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert ElixirMarketWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
