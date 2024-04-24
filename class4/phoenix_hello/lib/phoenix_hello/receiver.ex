defmodule PhoenixHello.Receiver do
  use GenServer

  def start_link(opts \\ nil) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(opts) do
    {:ok, opts}
  end

  @doc """
    Function that sends msg to Receiver process started on connected node and returns response from it.   
  """
  def send_msg(msg) do
    # write your code gere
  end

  @doc """
    Function that sends msg to all Receiver processes in a cluster including the node from which msg was sent
    and returns list of responses from nodes. 
  """
  def send_msg_to_all_nodes(msg) do
    # write your code gere
  end

  @impl GenServer
  def handle_call({msg, node}, _from, state) when is_atom(node) do
    IO.inspect(
      "#{inspect(msg)} message received on node #{inspect(Node.self())} from node: #{inspect(node)}"
    )

    {:reply, {msg, Node.self()}, state}
  end

  @impl GenServer
  def handle_info(msg, state) do
    IO.inspect("#{inspect(msg)} message received on node #{inspect(Node.self())}")
    {:noreply, state}
  end
end
