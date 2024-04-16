defmodule Exercises.Exercise8 do
  @doc """
  Modify exercise7 by adding trap_exit and handle exit signal 
   - spawn a new unregistered process, 
      - wait 1500ms 
      - print ":world is alive!" if process :world is alive
      - print ":world is dead!" otherwise
   input: none
   returns: pid
  """
  def process_link() do
    pid_hello =
      spawn(fn ->
        receive do
          :bad_msg -> raise("error")
          :die_normally -> :ok
        end
      end)

    Process.register(pid_hello, :hello)

    # write here your code

    world_pid =
      spawn(fn ->
        Process.register(self(), :world)
        Process.flag(:trap_exit, true)
        Process.link(pid_hello)
        Process.sleep(1000)
        send(:hello, :bad_msg)

        receive do
          msg ->
            IO.inspect(msg, label: "exit signal was caught and handled as normal msg")
            send(:test, msg)
        end

        # wait for another msg
        receive do
          msg ->
            msg
        end
      end)

    spawn(fn ->
      Process.sleep(1500)

      if Process.alive?(world_pid) do
        IO.inspect(":world is alive!")
      else
        IO.inspect(":world is dead!")
      end
    end)
  end
end
