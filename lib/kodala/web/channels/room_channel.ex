defmodule Kodala.Web.RoomChannel do
  use Kodala.Web, :channel
  require Logger

  def join("rooms:lobby", message, socket) do
    Process.flag(:trap_exit, true)
    :timer.send_interval(5000, :ping)
    send(self, {:after_join, message})

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
