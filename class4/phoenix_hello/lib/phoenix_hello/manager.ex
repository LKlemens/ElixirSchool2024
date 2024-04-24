defmodule PhoenixHello.Manager do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: via_tuple(name))
  end

  @impl GenServer
  def init(name) do
    Process.flag(:trap_exit, true)
    IO.inspect("initialize manager #{inspect(self())}, name: #{inspect(name)}")
    {:ok, name}
  end

  def get_name(pid) do
    GenServer.call(pid, :get_name)
  end

  def handle_call(:get_name, _from, name) do
    {:reply, name, name}
  end

  @impl GenServer
  def handle_info({:EXIT, _from, reason}, state) do
    IO.inspect("#{inspect(reason)} EXIT message received on node #{inspect(Node.self())}")
    {:stop, reason, state}
  end

  def handle_info(msg, state) do
    IO.inspect("#{inspect(msg)} message received on node #{inspect(Node.self())}")
    {:noreply, state}
  end

  @impl GenServer
  def terminate(reason, _state) do
    IO.inspect(reason, label: "terminate #{inspect(self())}")
  end

  defp via_tuple(name), do: {:via, Horde.Registry, {PhoenixHello.DistributedRegistry, name}}
end
