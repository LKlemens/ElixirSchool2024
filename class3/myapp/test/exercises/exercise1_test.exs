defmodule Exercises.Exercise1Test do
  use ExUnit.Case, async: false

  alias MyApp.{Item, ShopInventory}

  @tag :exercise1
  test "Should list init items" do
    init_items = [%Item{name: "bread", price: 6}]
    {:ok, pid} = GenServer.start_link(ShopInventory, init_items)
    items = GenServer.call(pid, :list_items)
    assert init_items == items
  end

  @tag :exercise1
  test "Should get item by name" do
    init_items = [init_item] = [%Item{name: "bread", price: 6}]
    {:ok, pid} = GenServer.start_link(ShopInventory, init_items)
    item = GenServer.call(pid, {:get_item_by_name, "bread"})
    assert init_item == item
  end

  @tag :exercise1
  test "Should return nil when no item found" do
    init_items = [%Item{name: "bread", price: 6}]
    {:ok, pid} = GenServer.start_link(ShopInventory, init_items)
    item = GenServer.call(pid, {:get_item_by_name, "juice"})
    assert nil == item
  end

  @tag :exercise1
  test "Should create an item" do
    {:ok, pid} = GenServer.start_link(ShopInventory, [])
    new_item = %Item{name: "bread", price: 6}
    GenServer.cast(pid, {:create_item, new_item})
    items = GenServer.call(pid, :list_items)
    assert [new_item] == items
  end

  @tag :exercise1
  test "Should delete an item" do
    init_items = [init_item] = [%Item{name: "bread", price: 6}]
    {:ok, pid} = GenServer.start_link(ShopInventory, init_items)
    GenServer.cast(pid, {:delete_item, init_item})
    items = GenServer.call(pid, :list_items)
    assert [] == items
  end
end
