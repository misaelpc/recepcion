defmodule Reception.Counter do
  def start_link do
    Agent.start_link(fn -> 1 end, name: __MODULE__)
  end

  def next_folio do
    Agent.get_and_update(__MODULE__, fn counter -> {counter, counter + 1} end)
  end

end