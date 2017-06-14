defmodule Kodala.Desk.Chat do
  use Ecto.Schema
  import Ecto.Changeset
  alias Kodala.Desk.Chat


  schema "chats" do
    field :room, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(%Chat{} = chat, attrs) do
    chat
    |> cast(attrs, [:room, :status])
    |> validate_required([:room, :status])
  end
end
