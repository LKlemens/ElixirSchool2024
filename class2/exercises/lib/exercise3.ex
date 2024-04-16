defmodule Exercises.Exercise3 do
  @doc """
   Spawn a new process, register it under :hello name, wait for :ping message, print it out and terminate.
   input: none
   returns: pid
  """
  def wait_and_print() do
    spawn(fn ->
      Process.register(self(), :hello)

      receive do
        :ping = msg ->
          IO.inspect(msg)
      end
    end)
  end
end
