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

    result = Reception.Covalidator.validate_empty_document(document)
    		|> Reception.Covalidator.validate_xml_document
    		|> Reception.Covalidator.extract_seal_document
    		|> Reception.Covalidator.build_chain_template
    		|> Reception.Covalidator.get_hsm_sign

    case result do
    	{:error, message, _xml} ->  text conn, message	
    	{:ok, message, _xml} ->  text conn, message	
    end
  end  

end