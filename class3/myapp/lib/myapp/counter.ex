defmodule Counter do
  use GenServer

  def start_link(args) do
    initial_value = Keyword.get(args, :initial_value, 0)
    name = Keyword.get(args, :name, __MODULE__)
    GenServer.start_link(__MODULE__, initial_value, name: name)
  end

  ## Callbacks

  @impl true
  def init(counter) do
    {:ok, counter}
  end

  @impl true
  def handle_call(:get, _from, counter) do
    {:reply, counter, counter}
  end

  def handle_call({:bump, value}, _from, counter) do
    {:reply, counter, counter + value}
  end
end
