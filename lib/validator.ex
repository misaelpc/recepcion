defmodule Reception.Validator do
  use GenServer

  #####
  # External API
  def start_link() do
    file_xsd = '/Users/hiphoox/Development/Elixir/testbed/recepcion/BalanzaComprobacion_1_1.xsd'
    {_ok, xsd} = :xmerl_xsd.process_schema(file_xsd)
    GenServer.start_link( __MODULE__, xsd, name: __MODULE__)
  end

  def validate(xml) do
    GenServer.call __MODULE__, {:validate, xml}
  end

  #####
  # GenServer implementation

  def handle_call({:validate, xml}, _from, xsd) do 
      case :xmerl_xsd.validate(xml, xsd) do 
        {:error,_message} -> { :reply, {:error, "Esto salio mal"}, xsd}
        {_xml,_newState} ->   { :reply, {:ok}, xsd}
      end
  end

end