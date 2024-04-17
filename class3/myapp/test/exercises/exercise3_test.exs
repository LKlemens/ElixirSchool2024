defmodule Exercises.Exercise3Test do
  use ExUnit.Case, async: false

  alias MyApp.{Item, ShopInventory}

  @tag :exercise3
  test "Should list init items" do
    init_items = [%Item{name: "bread", price: 6}]
    ShopInventory.start_link(init_items)
    items = ShopInventory.list_items()
    assert init_items == items
  end

  @tag :exercise3
  test "Should get item by name" do
    init_items = [init_item] = [%Item{name: "bread", price: 6}]
    ShopInventory.start_link(init_items)
    item = ShopInventory.get_item_by_name("bread")
    assert init_item == item
  end

  @tag :exercise3
  test "Should create an item" do
    ShopInventory.start_link([])
    new_item = %Item{name: "bread", price: 6}
    ShopInventory.create_item(new_item)
    items = ShopInventory.list_items()
    assert [new_item] == items
  end

  @tag :exercise3
  test "Should delete an item" do
    init_items = [init_item] = [%Item{name: "bread", price: 6}]
    ShopInventory.start_link(init_items)
    ShopInventory.delete_item(init_item)
    items = ShopInventory.list_items()
    assert [] == items
  end
end
