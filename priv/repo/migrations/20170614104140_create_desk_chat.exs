defmodule Kodala.Repo.Migrations.CreateKodala.Desk.Chat do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :room, :string
      add :status, :string
      add :client_name, :string

      timestamps()
    end

  end
end
