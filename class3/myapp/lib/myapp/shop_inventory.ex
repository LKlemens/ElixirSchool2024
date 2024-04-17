defmodule MyApp.ShopInventory do
  use GenServer

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
  def init(_) do
    {:ok, []}
  end

  @impl true
  def handle_call(:list_items, _, state) do
    {:reply, :ok, state}
  end

  def handle_call({:get_item_by_name, _name}, _, state) do
    {:reply, :ok, state}
  end

  @impl true
  def handle_cast({:create_item, _item}, state) do
    {:noreply, state}
  end

  def handle_cast({:delete_item, _item}, state) do
    {:noreply, state}
  end

  # For supervisor testing
  def handle_cast(:crash, _state) do
    throw(:error)
  end
end
