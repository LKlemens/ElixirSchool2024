defmodule MyApp.InternalSupervisor do
  # Automatically defines child_spec/1
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  # basic
  @impl true
  def init(_init_arg) do
    children = [
      Counter
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  # one for one
  # @impl true
  # def init(_init_arg) do
  #   children = [
  #     %{
  #       id: Counter,
  #       start: {Counter, :start_link, [[name: :counter1, initial_value: 0]]}
  #     },
  #     %{
  #       id: Counter2,
  #       start: {Counter, :start_link, [[name: :counter2, initial_value: 1]]}
  #     },
  #     %{
  #       id: Counter3,
  #       start: {Counter, :start_link, [[name: :counter3, initial_value: 2]]}
  #     }
  #   ]

  #   Supervisor.init(children, strategy: :one_for_one)
  # end

  # one for all
  # @impl true
  # def init(_init_arg) do
  # children = [
  #   %{
  #     id: Counter,
  #     start: {Counter, :start_link, [[name: :counter1, initial_value: 0]]}
  #   },
  #   %{
  #     id: Counter2,
  #     start: {Counter, :start_link, [[name: :counter2, initial_value: 1]]}
  #   },
  #   %{
  #     id: Counter3,
  #     start: {Counter, :start_link, [[name: :counter3, initial_value: 2]]}
  #   }
  # ]

  #   Supervisor.init(children, strategy: :one_for_all)
  # end

  # rest_for_one
  # @impl true
  # def init(_init_arg) do
  #   children = [
  #     %{
  #       id: Counter,
  #       start: {Counter, :start_link, [[name: :counter1, initial_value: 0]]}
  #     },
  #     %{
  #       id: Counter2,
  #       start: {Counter, :start_link, [[name: :counter2, initial_value: 1]]}
  #     },
  #     %{
  #       id: Counter3,
  #       start: {Counter, :start_link, [[name: :counter3, initial_value: 2]]}
  #     }
  #   ]

  #   Supervisor.init(children, strategy: :rest_for_one)
  # end
end
