defmodule DataProvider do
  def feed_n_words(n) do
    options = [
      host: "localhost",
      port: 5672,
      username: "test",
      password: "test"
    ]

    {:ok, connection} = AMQP.Connection.open(options)
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, "my_queue", durable: true)

    Enum.each(1..n, fn _ ->
      guess_word =
        1..5
        |> Enum.to_list()
        |> Enum.map(fn _ -> Enum.random(?a..?z) end)
        |> :erlang.list_to_binary()

      AMQP.Basic.publish(channel, "", "my_queue", guess_word)
    end)

    AMQP.Connection.close(connection)
  end
end
