defmodule Reception.Validator do
  use GenServer

  #####
  # External API
  def start_link() do
    GenServer.start_link( __MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Reception.Schema.start_link('./BalanzaComprobacion_1_1.xsd')
  end

  def validate(xml) do
    GenServer.call __MODULE__, {:validate, xml}
  end

  #####
  # GenServer implementation

  def handle_call({:validate, xml}, _from, agent) do
    xsd = Agent.get(agent, fn result -> result end) 
    case :xmerl_xsd.validate(xml, xsd) do 
      {:error, message} ->
        parse_errors(message)
        { :reply, {:error, "Esto salio mal"}, xsd}
      {_xml,_newState} ->   
        { :reply, {:ok}, xsd}
    end
  end

  def parse_errors([],_), do: []

  def parse_errors([head | tail]) do
    IO.puts "***********************"
    IO.inspect head
    parse_errors(tail)
  end

end