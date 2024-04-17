defmodule Exercises.Exercise5Test do
  use ExUnit.Case, async: false

  alias MyApp.ShopInventory

  @tag :exercise5
  test "Application should start ShopInventory" do
    assert [] == ShopInventory.list_items()
  end
end
