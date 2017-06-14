defmodule Kodala.Account.Agent do
  use Ecto.Schema
  import Ecto.Changeset
  alias Kodala.Account.Agent


  schema "agents" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Agent{} = agent, attrs) do
    agent
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
