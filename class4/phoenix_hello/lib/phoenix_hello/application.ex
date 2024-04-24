defmodule PhoenixHello.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # exercise4: setup libcluster strategy that automatically connects node on localhost
    # https://hexdocs.pm/libcluster/readme.html#strategy-configuration
    # topologies = [
    #   example: [
    #     strategy: strategy,
    #     config: [timeout: 1000]
    #   ]
    # ]

    children = [
      PhoenixHelloWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:phoenix_hello, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixHello.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixHello.Finch},
      # exercise4: uncomment
      # {Cluster.Supervisor, [topologies, [name: PhoenixHello.ClusterSupervisor]]},
      # exercice3: uncomment Horde.Registry & PhoenixHello.ManagerSupervisor
      # {Horde.Registry, [name: PhoenixHello.DistributedRegistry, keys: :unique, members: :auto]},
      # {PhoenixHello.ManagerSupervisor,
      #  strategy: :one_for_one, members: :auto, process_redistribution: :active},
      # Start a worker by calling: PhoenixHello.Worker.start_link(arg)
      # {PhoenixHello.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixHelloWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixHello.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixHelloWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
