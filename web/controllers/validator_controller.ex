defmodule Reception.ValidatorController do
  use Phoenix.Controller

  plug :action

  def validate(conn, _params) do

	{:ok, document, _conn_details} = Plug.Conn.read_body(conn)

	request_body = :erlang.bitstring_to_list(document)

	{xml,_} = :xmerl_scan.string(request_body)
	file_xsd = './BalanzaComprobacion_1_1.xsd'

	{ok, xsd} = :xmerl_xsd.process_schema(file_xsd)
	{error, message} = :xmerl_xsd.validate(xml, xsd)
	
	IO.inspect message

	if error == xml do
		result = 'valido'
	else
		result = 'no valido'
	end

	text conn, result

  end

end