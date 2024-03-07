# Learning basics of Elixir Broadway

During the fourth class, we will learn about Broadway, which is an Elixir library for a concurrent, multi-stage tool for building data ingestion and data processing pipelines.

## A step by step work description

**Assumption**: There is a RabbitMQ running on a local machine with a `test/test` user, like in the same fashion as on previous classes. There is also a queue named `my_queue` defined in RabbitMQ.

Create a new Elixir project `mix new wordle_broadway --sup`.
Enter the project's directory `cd wordle_broadway`. 
Get the latest version of broadway_rabbitmq package from [hex](https://hex.pm/packages/broadway_rabbitmq) and add it to the deps list in the mix.exs file.
Get the dependencies `mix deps.get`.

Next create a module in a `wordle_broadway/lib/wordle_broadway.ex` file in lib folder:

```elixir
defmodule WordleBroadway do
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: WordleBroadway,
      producer: [
        module:
          {BroadwayRabbitMQ.Producer,
           queue: "my_queue",
           connection: [
             host: "localhost",
             port: 5672,
             username: "test",
             password: "test"
           ],
           qos: [
             prefetch_count: 1
           ]},
        concurrency: 7
      ],
      processors: [
        default: [
          concurrency: 5
        ]
      ],
      batchers: [
        default: [
          batch_size: 4,
          batch_timeout: 3000,
          concurrency: 5
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, message, _) do
    message
    # TODO add data processing
    |> Message.update_data(fn data -> data end)
  end

  @impl true
  def handle_batch(_, messages, _, _) do
    list = messages |> Enum.map(fn e -> e.data end)
    IO.inspect(list, label: "Got batch")
    messages
  end
end
```

and a file `wordle_broadway/lib/data_provider.ex` in the lib folder too:

```elixir
defmodule DataProvider do
  def feed_n_numbers(n) do
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
```

Next go to `wordle_broadway/lib/wordle_broadway/application.ex` and replace children list with: 
```elixir
children = [
      {WordleBroadway, []}
    ]
```

Start Elixir shell `iex -S mix`, you will see an error:

```elixir
warning: :on_failure should be specified for Broadway topology with name WordleBroadway; assuming :reject_and_requeue. See documentation for valid values: https://hexdocs.pm/broadway_rabbitmq/0.7.2/BroadwayRabbitMQ.Producer.html#module-acking
  (broadway_rabbitmq 0.7.2) lib/broadway_rabbitmq/producer.ex:436: BroadwayRabbitMQ.Producer.init/1
  (broadway 1.0.3) lib/broadway/topology/producer_stage.ex:70: Broadway.Topology.ProducerStage.init/1
  (gen_stage 1.1.2) lib/gen_stage.ex:1731: GenStage.init/1
  (stdlib 3.17.1) gen_server.erl:423: :gen_server.init_it/2
  (stdlib 3.17.1) gen_server.erl:390: :gen_server.init_it/6
  (stdlib 3.17.1) proc_lib.erl:226: :proc_lib.init_p_do_apply/3
```
to fix it we can add `on_failure: :reject,` after `queue: "my_queue",` parameter in the `lib/wordle_broadway/wordle_broadway.ex` file.

After fixing that, try running the shell again: `iex -S mix` and run `DataProvider.feed_n_words(15)`.

Notice that the shell will print the 3 batches (each element containing 4 elements) immediately and then after a while (about 3 seconds) the 4th batch with 3 elements will be printed.