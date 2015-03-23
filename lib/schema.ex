defmodule Reception.Schema do
	def start_link(path) do
    Agent.start_link(fn -> xsd_schema(path) end ,name: __MODULE__)
  end

  defp xsd_schema(path) do
    {_ok, xsd} = :xmerl_xsd.process_schema(path)
    xsd
  end

  def get_schema(agent) do
    Agent.get(agent, fn list -> list end)
  end
end