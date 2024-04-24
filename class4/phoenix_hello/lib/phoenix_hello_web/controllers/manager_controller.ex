defmodule PhoenixHelloWeb.ManagerController do
  use PhoenixHelloWeb, :controller

  def index(conn, _params) do
    PhoenixHello.ManagerSupervisor.start_random()
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :index, layout: false)
  end
end
