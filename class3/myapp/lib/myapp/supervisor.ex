defmodule MyApp.Supervisor do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  # =====EXERCISE 4=====
  @impl true
  def init(_init_arg) do
    children = [
      {MyApp.ShopInventory, []}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
