defmodule MyApp.ShopInventory do
  use GenServer

  alias MyApp.Item

  # =====EXERCISE 2=====
  # Client API
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  def create_item(_pid, _item) do
    # Your code here
  end

  def list_items(_pid) do
    # Your code here
  end

  def delete_item(_pid, _item) do
    # Your code here
  end

  def get_item_by_name(_pid, _name) do
    # Your code here
  end

  # =====EXERCISE 3=====
  def create_item(_item) do
    # Your code here
  end

  def list_items() do
    # Your code here
  end

  def delete_item(_item) do
    # Your code here
  end

  def get_item_by_name(_name) do
    # Your code here
  end

  # =====EXERCISE 1=====
  # Server API
  @impl true
  def init(init_items) do
    {:ok, init_items}
  end

  @impl true
  def handle_call(:list_items, _, items) do
    {:reply, items, items}
  end

  def handle_call({:get_item_by_name, name}, _, items) do
    item = Enum.find(items, fn %Item{name: n} -> name == n end)
    {:reply, item, items}
  end

  @impl true
  def handle_cast({:create_item, item}, items) do
    {:noreply, [item | items]}
  end

  def handle_cast({:delete_item, item}, items) do
    new_items = List.delete(items, item)
    {:noreply, new_items}
  end

  # For supervisor testing
  def handle_cast(:crash, _items) do
    throw(:error)
  end
end
