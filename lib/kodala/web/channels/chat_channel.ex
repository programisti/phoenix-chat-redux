defmodule Kodala.Web.ChatChannel do
  use Phoenix.Channel
  require Logger

  def join("chat:" <> id, msg, socket) do
    Process.flag(:trap_exit, true)
    case msg do
      %{"name" => name, "type" => "client"} ->
        chat = Chat.get(id)
        auth = %{type: "client", name: name, chat: chat}
        socket = assign(socket, :auth, msg)

      %{"name" => name, "type" => "agent"} ->
        chat_tuple = Chat.add_agent(id, name)
        case chat_tuple do
          {:ok, chat} ->
            #authorize agent
            auth = %{type: "agent", name: name, chat: chat}
            socket = assign(socket, :auth, auth)
            #send message to channel about joined agent
            send(self, {:agent_entered, auth})
          {:returned, chat} ->
            #authorize new agent
            auth = %{type: "agent", name: name, chat: chat}
            socket = assign(socket, :auth, auth)
            send(self, {:agent_entered, auth})
          {:started, msg} ->
            #possibly never beed executed
            Logger.error "> chat started: #{inspect msg}"
        end
      _ ->
        Logger.error "> Anonmymous Entered"
    end

    {:ok, socket}
  end

  def handle_info({:agent_entered, msg}, socket) do
    params = %{type: "system", name: "system", chat: msg.chat}
    Kodala.Endpoint.broadcast! "rooms:" <> msg.chat.room, "chat_taken", params
    broadcast! socket, "agent_entered", msg
    broadcast! socket, "new_msg", %{user: "SYSTEM", body: "#{msg.type} #{msg.name} joined chat"}
    {:noreply, socket}
  end

  def handle_in("new_msg", msg, socket) do
    [_, id] = String.split(socket.topic, ":")
    {chat_id, _} = Integer.parse(id)
    message = %{user: msg["user"], body: msg["body"], chat_id: chat_id}

    Logger.error "> qwe: #{inspect msg}"

    q = Query.db('kodala')
    |> Query.table('messages')
    |> Query.insert(msg)
    |> RethinkRepo.run
    Logger.error "> qwe: #{inspect q}"

    broadcast! socket, "new_msg", msg
    {:noreply, socket}
  end

  def terminate(reason, _socket) do
    name = _socket.assigns.auth["name"]
    type = _socket.assigns.auth["type"]
    broadcast! _socket, "new_msg", %{"user" => "SYSTEM", "body" => "#{type} #{name} leaved chat"}
    :ok
  end

end
