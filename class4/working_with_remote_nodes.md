This is an example of how easy it is to work with distribution.

Start 2 nodes in 2 terminals side by side, both running elixir:
```
iex --name elixir1@127.0.0.1  --cookie my_cookie
```
```
iex --name elixir2@127.0.0.1  --cookie my_cookie
```

```elixir
# In node elixir1:
Process.register(self(), :elixir_shell)
:net_adm.ping(:"elixir2@127.0.0.1")
receive do
    {:xd2, sender: sender} -> {:ok, sender}
# after
#     10_000 -> :timeout
end

# In node elixir2:
send(self(), :xd)
flush()

[elixir1_node] = :erlang.nodes()
send({:elixir_shell, elixir1_node}, {:xd2, sender: self()})
```

Start observer and show list of nodes in Nodes tab.

```elixir
:observer.start()
```

Now let's connect with an Erlang node to the Elixir nodes.
In the third shell start Erlang node:
```
erl -name erlang1@127.0.0.1  -setcookie my_cookie
```
and then connect this node to the Elixir nodes:

```erlang
net_adm:ping('elixir1@127.0.0.1').

% Let's now see our current node
node().
% And all the nodes this node is connected to:
nodes().

% start remote tracing (maybe explain process group leader)
dbg:tracer(process, {fun dbg:dhandler/2, standard_io}).
dbg:n('elixir1@127.0.0.1').
dbg:p(all, c).
dbg:tpl(lists, seq, x).

rpc:call('elixir1@127.0.0.1', lists, seq, [1, 5]).

rpc:call('elixir1@127.0.0.1', erlang, self, []).

% 1
rpc:call('elixir1@127.0.0.1', 'Elixir.IO', inspect, ["Hello from the erlang1 node"]).
% 2
{elixir_shell, 'elixir1@127.0.0.1'} ! {what_group_leader, self()}.
% 4
{ok, Pid} = receive
    {group_leader, Pid} -> {ok, Pid}
end.
% 5
rpc:call('elixir1@127.0.0.1', 'Elixir.IO', binwrite, [Pid, "Hello from the erlang1 node"]).
```

```elixir
# 3
receive do
    {:what_group_leader, erlang_shell_process} ->
        send(erlang_shell_process, {:group_leader,  Process.group_leader()})
end

```
Now let's start yet another Erlang node (with extra hidden flag) and let's see what's the difference:

```
erl -name erlang2@127.0.0.1  -setcookie my_cookie -hidden 
```

```erlang
net_adm:ping('erlang1@127.0.0.1').

% Let's now see our current node
node().
% And all the nodes this node is connected to:
nodes().
```

Now let's start yet another Erlang node (with different cookie) and let's see what's the difference:
```
erl -name erlang3@127.0.0.1  -setcookie NOT_my_cookie
```
```erlang
net_adm:ping('erlang1@127.0.0.1').

% Run get_cookie(). in erlang1 and erlang3 nodes and see the difference.
get_cookie().

% Let's now see our current node
node().
% And all the nodes this node is connected to:
nodes().
```

