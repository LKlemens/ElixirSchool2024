defmodule PhoenixHelloWeb.CounterLive do
  use PhoenixHelloWeb, :live_view

  def render(assigns) do
    # TODO display counter and add button "Add +1"
    ~H"""
    <p>exercise6</p>
    """
  end

  # Initialize timer when the LiveView mounts
  def mount(_params, _session, socket) do
    socket = assign(socket, :counter, 0)

    {:ok, socket}
  end

  def handle_event("counter", _params, socket) do
    # TODO update counter here
    {:noreply, socket}
  end
end
