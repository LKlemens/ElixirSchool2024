defmodule Exercises.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExercisesWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:exercises, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Exercises.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Exercises.Finch},
      # Start a worker by calling: Exercises.Worker.start_link(arg)
      # {Exercises.Worker, arg},
      # Start to serve requests, typically the last entry
      ExercisesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exercises.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExercisesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
