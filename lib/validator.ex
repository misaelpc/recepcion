defmodule Reception.Validator do
  use GenServer

  #####
  # External API
  def start_link() do
    file_xsd = './BalanzaComprobacion_1_1.xsd'
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
        {:error, message} ->
          #IO.inspect :xmerl_xsd.format_error(message)
          parse_errors(message,xsd)
          { :reply, {:error, "Esto salio mal"}, xsd}
        {_xml,_newState} ->   { :reply, {:ok}, xsd}
      end
  end

  def parse_errors([],_), do: []

  def parse_errors([head | tail],xml) do
    IO.puts "***********************"
    IO.inspect :xmerl_xsd.format_error({xml,head})
    parse_errors(tail,xml)
  end

end