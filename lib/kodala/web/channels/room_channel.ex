defmodule Kodala.Web.RoomChannel do
  use Kodala.Web, :channel
  require Logger

  def join("rooms:" <> room, message, socket) do
    Process.flag(:trap_exit, true)
    # :timer.send_interval(5000, :ping)
    IO.inspect room
    # IO.inspect socket
    send(self, {:after_join, message})
    # case msg do
    #   %{"type" => "client", "name" => client, "ip" => ip} ->
    #     chat = Desk.create_chat(%{client: client, room: room})
    #     auth = %{type: "client", name: client, chat: chat}
    #     socket = assign(socket, :auth, auth)
    #     send(self, {:client_joined, chat})
    #   %{"type" => "agent", "name" => agent} ->
    #     auth = %{type: "agent", name: agent, room: room}
    #     socket = assign(socket, :auth, auth)
    #     send(self, {:agent_joined, auth})
    #   %{type: "system", name: "system", chat: chat} ->
    #     socket = assign(socket, :auth, msg)
    #   _ ->
    #     auth = %{ type: "anon", name: "anon"}
    #     socket = assign(socket, :auth, auth)
    # end

    {:ok, socket}
  end

  def join("rooms:" <> _private_subtopic, _message, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("rooms:lobby", params, socket) do
    broadcast! socket, "new:msg", params
    {:noreply, socket}
  end

  def handle_info({:after_join, msg}, socket) do
    broadcast! socket, "user:entered", %{user: msg["user"]}
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end
  def handle_info(:ping, socket) do
    push socket, "new:msg", %{user: "SYSTEM", body: "ping"}
    {:noreply, socket}
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end

  def handle_in("new:msg", msg, socket) do
    broadcast! socket, "new:msg", %{user: msg["user"], body: msg["body"]}
    {:reply, {:ok, %{msg: msg["body"]}}, assign(socket, :user, msg["user"])}
  end

  # def join("todos", _params, socket) do
  #   todos = TodoServer.all()
  #   {:ok, %{ todos: todos }, socket }
  # end
  #
  # def handle_in("new:todo", params, socket) do
  #   todo = params["text"]
  #   TodoServer.add(todo)
  #   broadcast! socket, "new:todo", %{
  #     text: todo
  #   }
  #
  #   {:noreply, socket}
  # end
end
