defmodule Exercises.Exercise4Test do
  use ExUnit.Case, async: false

  alias MyApp.ShopInventory

  @tag :exercise4
  test "Should spawn ShopInventory" do
    MyApp.Supervisor.start_link([])
    items = ShopInventory.list_items()
    assert [] == items
  end

  @tag :exercise4
  test "Should restart ShopInventory" do
    MyApp.Supervisor.start_link([])
    GenServer.cast(ShopInventory, :crash)
    Process.sleep(100)
    items = ShopInventory.list_items()
    assert [] == items
  end
end
