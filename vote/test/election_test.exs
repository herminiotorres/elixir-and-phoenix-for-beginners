defmodule ElectionTest do
  use ExUnit.Case, async: true
  doctest Election

  setup do
    %{election: %Election{}}
  end

  test "updating election name from a command", %{election: election} do
    command = "name San Francisco Mayor"
    election = Election.update(election, command)
    assert election == %Election{name: "San Francisco Mayor"}
  end

  test "adding a new candidate from a command", %{election: election} do
    command = "add Will Ferrell"
    election = Election.update(election, command)
    assert election == %Election{candidates: [%Candidate{id: 1, name: "Will Ferrell"}], next_id: 2}
  end

  test "voting for a candidate from a command", %{election: election} do
    command_add = "add Will Ferrell"
    command_vote = "v 1"

    election =
      [command_add, command_vote]
      |> Enum.reduce(election, fn cmd, election -> Election.update(election, cmd) end)

    assert election == %Election{candidates: [%Candidate{id: 1, name: "Will Ferrell", votes: 1}], next_id: 2}
  end

  test "invalid command", %{election: election} do
    command = "invalid command"
    election = Election.update(election, command)
    assert election == %Election{candidates: [], name: "", next_id: 1}
  end

  test "quitting the app", %{election: election} do
    command = "quit"
    election = Election.update(election, command)
    assert election == :quit
  end
end
