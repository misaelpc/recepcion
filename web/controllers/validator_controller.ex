defmodule Reception.ValidatorController do
  use Phoenix.Controller

  plug :action

  def validate(conn, _params) do

    {:ok, document, _conn_details} = Plug.Conn.read_body(conn)
    request_body = :erlang.bitstring_to_list(document)
    
    try do
      {xml,_} = :xmerl_scan.string(request_body)

      case Reception.Validator.validate(xml) do 
        {:error,message} -> text conn, "XML no cumple con la addenda"  
        {:ok} ->  Reception.Secure.save(xml,request_body)
                  text conn, "XML Valid"     
      end

    catch
      :exit, _ -> text conn, "XML INVALIDO"
    end

  end

  def document(conn, _params) do
    document = Reception.Secure.get_document(_params["id"])
    json conn, document
  end

end