defmodule PhoenixHello.ManagerSupervisor do
  @moduledoc """
    A distributed supervisor that dynamically adds and monitors PIDs across the cluster.
  """
  use Horde.DynamicSupervisor

  alias PhoenixHello.Manager

  require Logger

  def start_link(args) do
    Horde.DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  @spec start_manager(key :: String.t()) :: {:ok, pid()} | {:error, nil}
  def start_manager(nil) do
    {:error, nil}
  end

  def start_manager(key) do
    spec = {Manager, key}

    case lookup(key) do
      nil ->
        case Horde.DynamicSupervisor.start_child(__MODULE__, spec) do
          {:ok, _pid} = resp ->
            Logger.info("Successfully created Manager", id: key)
            resp

          {:error, {:already_started, pid}} ->
            Logger.info("Manager already started", id: key)
            {:ok, pid}
        end

      pid ->
        Logger.info("Manager already started", id: key)
        {:ok, pid}
    end
  end

  @doc """
    Stops Manager
  """
  @spec stop_manager(child_pid :: pid()) :: :ok
  def stop_manager(child_pid) do
    Horde.DynamicSupervisor.terminate_child(__MODULE__, child_pid)
  end

  def start_random(num) do
    Enum.map(1..num, fn _ ->
      name = Base.encode16(:crypto.strong_rand_bytes(8))
      start_manager(name)
    end)
  end

  def start_random() do
    names = [
      "Ethan",
      "Olivia",
      "Mason",
      "Sophia",
      "Liam",
      "Ava",
      "Noah",
      "Isabella",
      "Lucas",
      "Mia"
    ]

    Enum.map(names, fn name ->
      # TODO exercise5  start it under dystributed supervisor
      PhoenixHello.Manager.start_link(name)
      name
    end)
  end

  def lookup(key) do
    case Horde.Registry.lookup(PhoenixHello.DistributedRegistry, key) do
      [{pid, _}] ->
        pid

      [] ->
        nil
    end
  end

  @impl Horde.DynamicSupervisor
  def init(args) do
    Horde.DynamicSupervisor.init(args)
  end
end
