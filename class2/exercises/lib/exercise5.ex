defmodule Exercises.Exercise5 do
  @doc """
   Spawn a new process, register it under :hello name, receive :second msg first, send it to :test process, 
   and after that receive :first one and send it to :test process too
   input: none
   returns: pid
  """
  def selective_receive() do
    spawn(fn ->
      Process.register(self(), :hello)

      receive do
        :second ->
          IO.inspect("received second")
          send(:test, :second)
      end

      receive do
        :first ->
          IO.inspect("received first")
          send(:test, :first)
      end
    end)
  end
end
