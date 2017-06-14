defmodule Kodala.Web.RoomChannel do
  use Kodala.Web, :channel
  alias Kodala.Desk
  require Logger

  def join("rooms:" <> room, message, socket) do
    Process.flag(:trap_exit, true)
    case socket.assigns do
      %{type: "client", name: name} ->
        chat = Desk.create_chat(%{client_name: name, room: room, status: "active"})
        socket = assign(socket, :chat, chat)
        send(self, {:client_joined, message})
      %{type: "agent", name: name} ->
        send(self, {:agent_joined})
      _ ->
        IO.inspect "params not matching!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    end

    {:ok, socket}
  end

  def terminate(reason, socket) do
    case socket.assigns do
      %{type: "client", name: client, chat: chat} ->
        Logger.error "> terminate chat.id: #{inspect chat.id}"
        send(self, {:client_leaved, chat})
      %{type: "agent", name: agent, room: room} ->
        send(self, {:agent_leaved, socket.assigns})
      _ -> Logger.error "> anonymous leaved"
    end
    :ok
  end

  def handle_info({:client_joined, message}, socket) do
    broadcast! socket, "customer_entered", message
    push socket, "chat_created", message
    {:noreply, socket}
  end

  def handle_info({:client_leaved, chat}, socket) do
    Logger.error "> handle_info client leaved"
    broadcast! socket, "chat_ended", chat
    {:noreply, socket}
  end

  def handle_out("chat_ended", chat, socket) do
    Logger.error "> handle_out chat_ended msg: #{inspect chat}"
    Chat.end_chat chat.id
    push socket, "chat_ended", chat
    {:noreply, socket}
  end

  def handle_info({:agent_joined, msg}, socket) do
    broadcast! socket, "agent_entered", msg
    {:noreply, socket}
  end

  def handle_info({:agent_leaved, msg}, socket) do
    {:noreply, socket}
  end

  def handle_out("chat_taken", chat_id, socket) do
    push socket, "chat_taken", chat_id
    {:noreply, socket}
  end

  def handle_out("agent_entered", chat_id, socket) do
    push socket, "agent_entered", chat_id
    {:noreply, socket}
  end

  def handle_out("customer_entered", msg, socket) do
    push socket, "customer_entered", msg
    {:noreply, socket}
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
