defmodule MyApp.ShopInventory do
  use GenServer

  alias MyApp.Item

  # =====EXERCISE 2=====
  # Client API
  def start_link(init_items) do
    GenServer.start_link(__MODULE__, init_items, name: __MODULE__)
  end

  def create_item(pid, item) do
    GenServer.cast(pid, {:create_item, item})
  end

  def list_items(pid) do
    GenServer.call(pid, :list_items)
  end

  def delete_item(pid, item) do
    GenServer.cast(pid, {:delete_item, item})
  end

  def get_item_by_name(pid, name) do
    GenServer.call(pid, {:get_item_by_name, name})
  end

  # =====EXERCISE 3=====
  def create_item(item) do
    GenServer.cast(__MODULE__, {:create_item, item})
  end

  def list_items() do
    GenServer.call(__MODULE__, :list_items)
  end

  def delete_item(item) do
    GenServer.cast(__MODULE__, {:delete_item, item})
  end

  def get_item_by_name(name) do
    GenServer.call(__MODULE__, {:get_item_by_name, name})
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
