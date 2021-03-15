defmodule Poll do
  defstruct candidates: []

  def new(candidates \\ []) do
    %Poll{candidates: candidates}
  end

  def start_link() do
    spawn_link(__MODULE__, :run, [new()])
  end

  def add_candidate(pid, name) do
    send(pid, {:add_candidate, name})
  end

  def vote(pid, name) do
    send(pid, {:vote, name})
  end

  def exit(pid) do
    send(pid, :exit)
  end

  def candidates(pid) do
    send(pid, {:candidates, self()})

    receive do
      {^pid, candidates} -> candidates
    after
      5_000 -> nil
    end
  end

  def run(poll) do
    receive do
      msg ->
        case handle(msg, poll) do
          :exit -> :exit
          poll -> run(poll)
        end
    end
  end

  def handle({:add_candidate, name}, poll) do
    candidates = [Candidate.new(name) | poll.candidates]
    %{poll | candidates: candidates}
  end

  def handle({:vote, name}, poll) do
    candidates = Enum.map(poll.candidates, &do_vote(&1, name))

    %{poll | candidates: candidates}
  end

  def handle({:candidates, pid}, poll) do
    send(pid, {self(), poll.candidates})
    poll
  end

  def handle(:exit, _poll), do: :exit

  def do_vote(%Candidate{name: name, votes: votes} = candidate, name) do
    %{candidate | votes: votes + 1}
  end

  def do_vote(candidate, _name), do: candidate

  # TODO: Implement functions neccesary to make the tests in
  # `test/poll_test.exs` pass. More info in README.md
end
