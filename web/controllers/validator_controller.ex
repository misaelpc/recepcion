defmodule Reception.ValidatorController do
  use Phoenix.Controller

  plug :action

  def validate(conn, _params) do

  {:ok, document, _conn_details} = Plug.Conn.read_body(conn)

    request_body = :erlang.bitstring_to_list(document)

    try do
      {xml,_} = :xmerl_scan.string(request_body)
     
      file_xsd = './BalanzaComprobacion_1_1.xsd'
      {ok, xsd} = :xmerl_xsd.process_schema(file_xsd)

      case :xmerl_xsd.validate(xml, xsd) do 
        {:error,message} -> Reception.Secure.save(xml,request_body)
                            text conn, "XML no cumple con la addenda"  
        {xml,message} -> text conn, "XML Valid"     
      end

    catch
      :exit, error -> text conn, "XML INVALIDO"
    end
  end

end