defmodule Reception.Covalidator do

  @query_seal '/BCE:Balanza/@Sello'
  @chain_template "||1.0|{uuid}|{date}|{seal}|{certificate_number}||"
  @certificate_number "1234567890"
  @format_date "%Y-%m-%dT%H:%M:%S"
  @template_tfd '<tfd:TimbreFiscalDigital xsi:schemaLocation="http://www.sat.gob.mx/TimbreFiscalDigital http://www.sat.gob.mx/sitio_internet/cfd/TimbreFiscalDigital/TimbreFiscalDigital.xsd" selloSAT="{SELLO_SAT}" noCertificadoSAT="{NO_CERT_SAT}" selloCFD="{SELLO_CFD}" FechaTimbrado="{FECHA_TIMBRADO}" UUID="{UUID}" version="1.0" xmlns:tfd="http://www.sat.gob.mx/TimbreFiscalDigital"/>'

  #@url 'http://127.0.0.1:4000/api/hsm/{template}'
  @url 'http://127.0.0.1:4000/api/hsm/012345678901234567890123456789'

  def validate_empty_document(document) do
    document_request = document
    case String.first(document) do
	  nil -> {:error, "Documento vacio"}
	  document -> {:ok, "Proceso realizado con exito", document_request}
	end
  end	

  def validate_xml_document(result) do
  	try do
  	  case result do
  	  	  {:error, message} -> {:error, message, nil}
  	   	  {:ok, _message, document} -> 
  	   	    request_body = :erlang.bitstring_to_list(document) 
            case :xmerl_scan.string(request_body) do
              {xml, _} -> {:ok, "Proceso realizado con exito", xml}
            end
  	  end
  	catch
      :exit, _ -> {:error, "Estructura de XML no valida", nil}
  	end  
  end

  def extract_seal_document(result) do
    case result do
	  {:error, message, _xml} -> {:error, message, nil}
	  {:ok, _message, xml} -> 
	  	[seal] = :xmerl_xpath.string(@query_seal, xml)
	    case [seal] do
	    	[] -> {:error, "Documento no contiene el elemento sello", nil}
	    	xml -> {:ok, "Proceso realizado con exito", {xml, elem(seal, 8)}}
	    end	
	end
  end

  def build_chain_template(result) do
  	case result do
	  {:error, message, _response} -> {:error, message, nil}
	  {:ok, _message, {xml, seal}} -> 
	  	template = String.replace(@chain_template, "{uuid}", UUID.uuid1)
	  	template = String.replace(template, "{date}", Chronos.Formatter.strftime({Chronos.today, {13, 35, 44}}, @format_date))
	    template = String.replace(template, "{seal}", to_string(seal))
		template = String.replace(template, "{certificate_number}", @certificate_number)
	  	{:ok, _message, {xml, seal, template}}
	end
  end

  def get_hsm_sign(result) do
  	case result do
   	  {:error, message, _response} -> {:error, message, nil}
	  {:ok, _message, {xml, seal, template}} -> 
  	    
  	    case :httpc.request(:post, {@url, [], 'text/xml;charset=UTF-8', ''}, [], []) do	
          {:ok, response} ->  IO.inspect response
          	{:ok, _message, {xml, seal, template, response}}
            
      	  {:error, error} -> {:error, error}
      	end
	end	
  end

end