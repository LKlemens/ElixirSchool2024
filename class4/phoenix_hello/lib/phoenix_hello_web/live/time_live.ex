defmodule PhoenixHelloWeb.TimeLive do
  use PhoenixHelloWeb, :live_view

  def render(assigns) do
    ~H"""
    <span><%= @timer_value %></span>

    <br />
    <button class="button" phx-click="start_managers">Start Managers!</button>

    <br />
    <ul>
      <%= for item <- @list_of_running_managers do %>
        <li><%= item %></li>
      <% end %>
    </ul>
    """
  end

  # Initialize timer when the LiveView mounts
  def mount(_params, _session, socket) do
    list_of_running_managers = list_of_running_managers()

    socket =
      socket
      |> assign(:timer_value, DateTime.utc_now())
      |> assign(:list_of_running_managers, list_of_running_managers)
      |> assign(:button_clicked, false)

    schedule_update_timer(socket)
    {:ok, socket}
  end

  # Handle timer messages to update the LiveView
  def handle_info(:update_timer, socket) do
    schedule_update_timer(socket)
    {:noreply, update_timer(socket)}
  end

  def handle_event("start_managers", _params, socket) do
    list_of_running_managers = PhoenixHello.ManagerSupervisor.start_random()

    socket = assign(socket, :list_of_running_managers, list_of_running_managers)
    # Perform any desired actions when the button is clicked
    {:noreply, assign(socket, button_clicked: true)}
  end

  # Helper function to schedule timer updates
  defp schedule_update_timer(socket) do
    # Update every second
    Process.send_after(self(), :update_timer, 100)
    socket
  end

  # Helper function to update LiveView state
  defp update_timer(socket) do
    new_state = %{timer_value: DateTime.utc_now()}
    assign(socket, new_state)
  end

  defp list_of_running_managers() do
    Horde.DynamicSupervisor.which_children(PhoenixHello.ManagerSupervisor)
    |> Enum.map(fn {_, pid, _, _} ->
      PhoenixHello.Manager.get_name(pid)
    end)
  end
end
