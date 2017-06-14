defmodule Kodala.DeskTest do
  use Kodala.DataCase

  alias Kodala.Desk

  describe "chats" do
    alias Kodala.Desk.Chat

    @valid_attrs %{room: "some room", status: "some status"}
    @update_attrs %{room: "some updated room", status: "some updated status"}
    @invalid_attrs %{room: nil, status: nil}

    def chat_fixture(attrs \\ %{}) do
      {:ok, chat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Desk.create_chat()

      chat
    end

    test "list_chats/0 returns all chats" do
      chat = chat_fixture()
      assert Desk.list_chats() == [chat]
    end

    test "get_chat!/1 returns the chat with given id" do
      chat = chat_fixture()
      assert Desk.get_chat!(chat.id) == chat
    end

    test "create_chat/1 with valid data creates a chat" do
      assert {:ok, %Chat{} = chat} = Desk.create_chat(@valid_attrs)
      assert chat.room == "some room"
      assert chat.status == "some status"
    end

    test "create_chat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Desk.create_chat(@invalid_attrs)
    end

    test "update_chat/2 with valid data updates the chat" do
      chat = chat_fixture()
      assert {:ok, chat} = Desk.update_chat(chat, @update_attrs)
      assert %Chat{} = chat
      assert chat.room == "some updated room"
      assert chat.status == "some updated status"
    end

    test "update_chat/2 with invalid data returns error changeset" do
      chat = chat_fixture()
      assert {:error, %Ecto.Changeset{}} = Desk.update_chat(chat, @invalid_attrs)
      assert chat == Desk.get_chat!(chat.id)
    end

    test "delete_chat/1 deletes the chat" do
      chat = chat_fixture()
      assert {:ok, %Chat{}} = Desk.delete_chat(chat)
      assert_raise Ecto.NoResultsError, fn -> Desk.get_chat!(chat.id) end
    end

    test "change_chat/1 returns a chat changeset" do
      chat = chat_fixture()
      assert %Ecto.Changeset{} = Desk.change_chat(chat)
    end
  end
end
