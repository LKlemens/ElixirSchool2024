defmodule MyApp.Application do
  use Application

  # =====EXERCISE 5=====
  @impl true
  def start(_type, _args) do
    children = [
      StackSupervisor,
      # Starts a supervisor by calling: MyApp.Supervisor.start_link([])
      # Note: this will break some of the previous tests which start
      #       a process explicitly because then GenServer.start_link/3
      #       returns {:error, {:already_started, pid}}
      MyApp.Supervisor
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
