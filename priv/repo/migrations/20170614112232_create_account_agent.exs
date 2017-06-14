defmodule Kodala.Repo.Migrations.CreateKodala.Account.Agent do
  use Ecto.Migration

  def change do
    create table(:agents) do
      add :name, :string

      timestamps()
    end

  end
end
