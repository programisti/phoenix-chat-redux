defmodule Kodala.Desk.Chat do
  use Ecto.Schema
  import Ecto.Changeset
  alias Kodala.Desk.Chat


  schema "chats" do
    field :room, :string
    field :status, :string
    field :client_name, :string

    timestamps()
  end

  @doc false
  def changeset(%Chat{} = chat, attrs) do
    chat
    |> cast(attrs, [:room, :status, :client_name])
    |> validate_required([:room, :status, :client_name])
  end
end
