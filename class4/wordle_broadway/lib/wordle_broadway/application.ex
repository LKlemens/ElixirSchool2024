defmodule WordleBroadway.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    DataProvider.feed_n_words(0)
    children = [
        {WordleBroadway, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WordleBroadway.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
