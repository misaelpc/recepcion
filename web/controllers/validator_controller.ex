defmodule Reception.ValidatorController do
  use Phoenix.Controller

  plug :action

  def validate(conn, _params) do

  	{:ok, document, _conn_details} = Plug.Conn.read_body(conn)
    
    file_xsd = './BalanzaComprobacion_1_1.xsd'

    {xml, misc} = :xmerl_scan.string(document)
	
	#{ok, xsd} = :xmerl_xsd.process_schema(file_xsd)
	#{error, message} = :xmerl_xsd.validate(misc, xsd)

    json conn, xml
  end

end