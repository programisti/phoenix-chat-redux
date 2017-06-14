defmodule Kodala.Account do
  alias Kodala.{ Repo, Account.Agent }

  def list_agents do
    Repo.all(Agent)
  end

  def get_agent!(id), do: Repo.get!(Agent, id)

  def create_agent(attrs \\ %{}) do
    %Agent{}
    |> Agent.changeset(attrs)
    |> Repo.insert()
  end

  def update_agent(%Agent{} = agent, attrs) do
    agent
    |> Agent.changeset(attrs)
    |> Repo.update()
  end

  def delete_agent(%Agent{} = agent) do
    Repo.delete(agent)
  end

  def change_agent(%Agent{} = agent) do
    Agent.changeset(agent, %{})
  end
end
