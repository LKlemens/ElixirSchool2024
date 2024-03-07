defmodule MyApp.Periodically do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    # Schedule work to be performed on start
    schedule_periodic_work(3_000)

    {:ok, state}
  end

  @impl true
  def handle_info(:work, state) do
    # Do the desired work here
    IO.inspect("In handle info")
    # Reschedule once more
    schedule_periodic_work(5_000)

    {:noreply, state}
  end

  defp schedule_periodic_work(period) do
    DateTime.utc_now() |> IO.inspect(label: :IN_SCHEDULE_PERIODIC_WORK)
    # We schedule the work to happen in 2 hours (written in milliseconds).
    # Alternatively, one might write :timer.hours(2)
    Process.send_after(self(), :work, period)
  end
end
