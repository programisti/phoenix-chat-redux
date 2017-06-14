defmodule Kodala.AccountTest do
  use Kodala.DataCase

  alias Kodala.Account

  describe "agents" do
    alias Kodala.Account.Agent

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def agent_fixture(attrs \\ %{}) do
      {:ok, agent} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_agent()

      agent
    end

    test "list_agents/0 returns all agents" do
      agent = agent_fixture()
      assert Account.list_agents() == [agent]
    end

    test "get_agent!/1 returns the agent with given id" do
      agent = agent_fixture()
      assert Account.get_agent!(agent.id) == agent
    end

    test "create_agent/1 with valid data creates a agent" do
      assert {:ok, %Agent{} = agent} = Account.create_agent(@valid_attrs)
      assert agent.name == "some name"
    end

    test "create_agent/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_agent(@invalid_attrs)
    end

    test "update_agent/2 with valid data updates the agent" do
      agent = agent_fixture()
      assert {:ok, agent} = Account.update_agent(agent, @update_attrs)
      assert %Agent{} = agent
      assert agent.name == "some updated name"
    end

    test "update_agent/2 with invalid data returns error changeset" do
      agent = agent_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_agent(agent, @invalid_attrs)
      assert agent == Account.get_agent!(agent.id)
    end

    test "delete_agent/1 deletes the agent" do
      agent = agent_fixture()
      assert {:ok, %Agent{}} = Account.delete_agent(agent)
      assert_raise Ecto.NoResultsError, fn -> Account.get_agent!(agent.id) end
    end

    test "change_agent/1 returns a agent changeset" do
      agent = agent_fixture()
      assert %Ecto.Changeset{} = Account.change_agent(agent)
    end
  end
end
