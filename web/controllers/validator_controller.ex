defmodule Reception.ValidatorController do
  use Phoenix.Controller

  plug :action

  def validate(conn, _params) do
    # IO.inspect Router.File.identify()
    {:ok, document, _conn_details} = Plug.Conn.read_body(conn)
    request_body = :erlang.bitstring_to_list(document)

    try do
      {xml,_} = :xmerl_scan.string(request_body)

      case SchemaValidation.Worker.validate(xml) do 
        {:error,message} -> 
          text conn, "XML no cumple con la addenda"  
        {:ok, "Schema Valid"} ->  
          #Reception.Secure.save(xml,request_body)
          text conn, "XML Valid"     
      end

    catch
      :exit, _ ->
        text conn, "XML INVALIDO"
    end

  end

  def document_encrypted(conn, _params) do
    document = Reception.Secure.get_document_encrypted(_params["id"])
    json conn, document
  end

  def document_unencrypted(conn, _params) do
    document = Reception.Secure.get_document_unencrypted(_params["id"])
    json conn, document
  end

  def chain_builder(conn, _params) do
    {:ok, document, _} = Plug.Conn.read_body(conn)

    result = Reception.Covalidator.isEmpty(document)
    		|> Reception.Covalidator.validate_xml
    		|> Reception.Covalidator.extract_seal
    		|> Reception.Covalidator.build_chain
    		|> Reception.Covalidator.get_hsm_sign
        |> Reception.Covalidator.build_response

    case result do
    	{:error, message} -> text conn, message	
    	{:ok, response} -> text conn, response
    end
  end  

end