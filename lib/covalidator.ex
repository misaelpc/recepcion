defmodule Reception.Covalidator do

  @query_seal '/BCE:Balanza/@Sello'
  @certificate_number "1234567890"
  @format_date "%Y-%m-%dT%H:%M:%S"
  @url 'http://127.0.0.1:4000/api/hsm/'

  def isEmpty() do
    {:error, "Documento vacio"}
  end 

  def isEmpty(document) do
    char = String.first(document)
    case char do
      nil -> {:error, "Documento vacio"}
      char -> {:ok, document}
    end
  end 

  def validate_xml() do
     {:error, "Documento vacio"}
  end

  def validate_xml({:error, message}) do
    {:error, message}
  end

  def validate_xml({:ok, document}) do
    try do
      request_body = :erlang.bitstring_to_list(document) 
      case :xmerl_scan.string(request_body) do
        {xml, _} -> {:ok, xml}
      end
    catch
      :exit, _ -> {:error, "Estructura de XML no valida"}
    end  
  end

  def extract_seal() do
    {:error, "Estructura de XML no valida"}
  end

  def extract_seal({:error, message}) do
    {:error, message}
  end

  def extract_seal({:ok, xml}) do
    seal = :xmerl_xpath.string(@query_seal, xml)
    case seal do
      [] -> {:error, "Documento no contiene el elemento sello"}
      xml -> [{_, _, _, _, _, _, _, _, seal_chain, _}] = seal
        {:ok, {xml, seal_chain}}
    end
  end
  
  def build_chain() do
    {:error, "Documento no contiene el elemento sello"}
  end

  def build_chain({:error, message}) do
   {:error, message}
  end

  def build_chain({:ok, {xml, seal}}) do
    uuid = UUID.uuid1
    date = Chronos.Formatter.strftime({Chronos.today, {13, 35, 44}}, @format_date)
    chain = "||1.0|#{uuid}|#{date}|#{to_string(seal)}|#{@certificate_number}||"
    IO.inspect chain
    {:ok, {xml, seal, uuid, date, chain}}
  end
  
  def get_hsm_sign() do
    {:error, "Cadena original de timbre no es valida"}
  end

  def get_hsm_sign({:error, message}) do
    {:error, message}
  end

  def get_hsm_sign({:ok, {xml, seal, uuid, date, chain}}) do
    case :httpc.request(:post, {'#{@url}HASH123456789', [], 'text/xml;charset=UTF-8', ''}, [], []) do 
      {:error, error} -> {:error, error}
      {:ok, response} -> {{_version, http_code, _reason}, _headers, sat_seal} = response
        {:ok, {xml, seal, uuid, date, chain, http_code, sat_seal}}
    end
  end

  def build_response() do
    {:error, "No es posible obtener firma SAT"}
  end

  def build_response({:error, message}) do
    {:error, message}
  end

  def build_response({:ok, {xml, seal, uuid, date, chain, http_code, sat_seal}}) when http_code != 200 do
    {:error, "No es posible obtener firma SAT, error al consumir el servicio de timbrado"}
  end 

  def build_response({:ok, {xml, seal, uuid, date, chain, http_code, sat_seal}}) do
    {:ok, to_string('<tfd:TimbreFiscalDigital xsi:schemaLocation="http://www.sat.gob.mx/TimbreFiscalDigital http://www.sat.gob.mx/sitio_internet/cfd/TimbreFiscalDigital/TimbreFiscalDigital.xsd" selloSAT="#{sat_seal}" noCertificadoSAT="#{@certificate_number}" selloCFD="#{to_string(seal)}" FechaTimbrado="#{date}" UUID="#{uuid}" version="1.0" xmlns:tfd="http://www.sat.gob.mx/TimbreFiscalDigital"/>')}
  end 
end