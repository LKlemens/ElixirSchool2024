### Dependencies

- docker
- Elixr & Erlang
- [caddy](https://caddyserver.com/docs/install#static-binaries)
  brew install caddy
  sudo apt install caddy
  choco install caddy

### Agenda

- distributed nodes
- horde
- libcluster
- phoenix live view

### Distributed nodes

To start up distrubuted node we have to set a node name using `-sname/-name`.
Nodes have to have the same cookie value.

#### Exmaple commands:

##### To start a new node:

```
iex --sname node1@localhost
```

##### To connect a node:

```
iex(1)> Node.connect("node1@localhost")
true
```

##### To send a message to different node:

```
iex(1)> send({pid/name, node}, msg)
msg
```

##### To list connected nodes:

```
iex(1)> Node.list()
[]
```

##### To print node name:

```
iex(1)> Node.self()
:nonode@nohost
```

##### Exercise 1

- Run two nodes - `:node1` and `:node2`
  - PORT=4005 iex --sname node1@localhost -S mix phx.server
  - PORT=4006 iex --sname node2@localhost -S mix phx.server
- Connect those nodes
- Start `Receiver.start_link()` on node1
- Start `Receiver.start_link()` on node2
- Implement `send_msg` function in `phoenix_hello/receiver.ex` file
- Run test `PhoenixHello.Tests.exercise1()`

##### Exercise 2

- Run two nodes - `:node1` and `:node2`
- Connect those nodes
- Start `Receiver.start_link()` on node1
- Start `Receiver.start_link()` on node2
- Implement `send_msg_to_all_nodes` function in `phoenix_hello/receiver.ex` file
- Run test `PhoenixHello.Tests.exercise2()`

### Horde

[Horde](https://github.com/derekkraan/horde) is a library providing distributed registry and supervisor.
Horde ensures that processes will keep working when nodes or connection fail.

##### Exercise 3

- kill nodes
- uncomment Horde.Registry & PhoenixHello.ManagerSupervisor in `phoenix_hello/application.ex`
- Run two nodes - `:node1` and `:node2`
- Connect those nodes
- start 1000 random processes `PhoenixHello.ManagerSupervisor.start_random(1000)`
  - what happend & why?
- kill one node
  - what happend & why?
- start killed node and connect to cluster
  - what happend & why?

### Libcluster

Automatically forming clusters of Erlang nodes

##### Exercise 4

- setup libcluster configuration in `phoenix_hello/application.ex`
- run two nodes and check if there are connected automatically `Node.list()`

### Loadbalancing & Horde

##### Exercise 5

- install caddy
- run caddy `caddy run` in `phoenix_hello` dir
- start 2 nodes on ports 4005, 4006
- open https://localhost:8080/hello
- spawn managers
- kill node which your user uses
- check if list of managers disappeard
- fix it using distributed supervisor in `PhoenixHello.ManagerSupervisor` module

### minimum number of nodes?

### LiveView

##### Exercise 6

- Add CounterLive to Router moduel
- Implement CounterLive by adding a button which increases counter by one and diplay a counter value

#### Email

klemens.lukaszczyk@erlang-solutions.com

#### References

- [PhoenixLiveView](https://pragprog.com/titles/liveview/programming-phoenix-liveview/) book
- [Elixir in Action 3rd Edition](https://www.amazon.com/Elixir-Action-Third-Sa%C5%A1a-Juric-ebook/dp/B0CVHVWP9M?ref_=ast_author_dp)

#### [Ankieta](https://docs.google.com/forms/d/e/1FAIpQLScs3lz9a2qJV2cTTzkzwWUp9Qhs4cO31MDo3N43fqxxKloVtA/viewform)
