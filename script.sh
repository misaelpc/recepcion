#!/bin/sh
for i in {1..100}; do  

curl -XPOST localhost:4000/api/validar -d '<?xml version="1.0" encoding="UTF-8"?><BCE:Balanza xmlns:BCE="www.sat.gob.mx/esquemas/ContabilidadE/1_1/BalanzaComprobacion" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="www.sat.gob.mx/esquemas/ContabilidadE/1_1/BalanzaComprobacion http://www.sat.gob.mx/esquemas/ContabilidadE/1_1/BalanzaComprobacion/BalanzaComprobacion_1_1.xsd" Version="1.1" RFC="AAA010101AAA" Mes="01" Anio="2015" TipoEnvio="N" FechaModBal="2015-01-01" noCertificado="20001000000100005867" Certificado="Temporal"><BCE:Ctas NumCta="1234567890" SaldoIni="123.45" Debe="123.45" Haber="123.45" SaldoFin="123.45"></BCE:Ctas></BCE:Balanza>'

done