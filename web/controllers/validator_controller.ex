defmodule Reception.ValidatorController do
  use Phoenix.Controller

  plug :action

  def validate(conn, _params) do

	{:ok, document, _conn_details} = Plug.Conn.read_body(conn)
   
   #se agrega xml local para ver si procesa la peticion
	doc = '<?xml version="1.0" encoding="UTF-8"?><DD:DoctoDigital xmlns:DD="http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/1" xmlns:cat="http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/1/Catalogos" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://esquemas.clouda.sat.gob.mx/archivos/DoctosDigitales/1 file:/Users/alonsotrevino/Google%20Drive/diverza-producto/Documento%20Digital/schemas/DoctoDigital1.xsd" Version="1.0" TipoDoctoDigital="TipoDoctoDigital0" Cert="Cert0" NumCert="NumCert1111111111111" FirmaContrib="FirmaContrib0"><DD:Emisor ERFC="ERFC0" ECURP="ECURP0" EApellPat="EApellPat0" EApellMat="EApellMat0" ENombre="ENombre0" EDenORazSoc="EDenORazSoc0" ECorreoE="ECorreoE0" ENumTel="ENumTel0"><DD:EmpleadoDe ERFCOrg="ERFCOrg0" EDenORazSocOrg="EDenORazSocOrg0"><DD:EUnidadOrg EUnidad="EUnidad0"/><DD:EUnidadOrg EUnidad="EUnidad1"/></DD:EmpleadoDe><DD:Domicilio ECalle="ECalle0" ENumExt="ENumExt0" ENumInt="ENumInt0" EColonia="EColonia0" ELocalidad="ELocalidad0" ERef="ERef0" EMunDel="EMunDel0" EEntidadF="EEntidadF0" EPais="EPais0" ECP="ECP0"/><DD:RepresentanteLegal ERFCRep="ERFCRep0" ECURPRep="ECURPRep0" EApellPatRep="EApellPatRep0" EApellMatRep="EApellMatRep0" ENombreRep="ENombreRep0"/></DD:Emisor><DD:Receptor RRFC="RRFC0" RCURP="RCURP0" RApellPat="RApellPat0" RApellMat="RApellMat0" RNombre="RNombre0" RDenORazSoc="RDenORazSoc0" RCorreoE="RCorreoE0" RNumTel="RNumTel0"><DD:EmpleadoDe RRFCOrg="RRFCOrg0" RDenORazSocOrg="RDenORazSocOrg0"><DD:RUnidadOrg RUnidad="RUnidad0"/><DD:RUnidadOrg RUnidad="RUnidad1"/></DD:EmpleadoDe><DD:Domicilio RCalle="RCalle0" RNumExt="RNumExt0" RNumInt="RNumInt0" RColonia="RColonia0" RLocalidad="RLocalidad0" RRef="RRef0" RMunDel="RMunDel0" REntidadF="REntidadF0" RPais="RPais0" RCP="RCP0"/><DD:RepresentanteLegal RRFCRep="RRFCRep0" RCURPRep="RCURPRep0" RApellPatRep="RApellPatRep0" RApellMatRep="RApellMatRep0" RNombreRep="RNombreRep0"/></DD:Receptor><DD:TipoDoctoDigital><anyElement/><anyElement/></DD:TipoDoctoDigital><DD:TipoDoctoDigital><anyElement/><anyElement/></DD:TipoDoctoDigital></DD:DoctoDigital>'
	

	#esquema cargado desde path local
	#file_xsd = '/Users/fernando.luna/Documents/diverza/development/www/resources/xsd/contabilidad/balanza/BalanzaComprobacion_1_1.xsd'

	#esquema cargado desde el proyecto
	file_xsd = './BalanzaComprobacion_1_1.xsd'
    
    #se comenta linea que recibe el documento del body
    #{xml, misc} = :xmerl_scan.string(to_char_list (document)

	{xml, misc} = :xmerl_scan.string(to_char_list (doc)
	{ok, xsd} = :xmerl_xsd.process_schema(file_xsd)
	{error, message} = :xmerl_xsd.validate(xml, xsd)



    json conn, error
  end

end