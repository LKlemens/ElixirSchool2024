defmodule Myapp.SeparateReply do
  use GenServer

  # Callbacks

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_call(:reply_in_one_second, from, state) do
    spawn(fn ->
      Process.sleep(1000)
      GenServer.reply(from, :replied_after_one_second)
    end)

    {:noreply, state}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end
end
