defmodule Reception.Secure do
  
  def save(xml,raw_file) do
    rfc_emisor = query('/BCE:Balanza/@RFC',xml)
    noCertificado = query('/BCE:Balanza/@noCertificado',xml)
    mes = query('/BCE:Balanza/@Mes',xml)
    anio = query('/BCE:Balanza/@Anio',xml)

  	document = %Reception.Document{rfc: encrypt(rfc_emisor), 
                         nocertificado: encrypt(noCertificado),  
                                   mes: to_string(mes), 
                                  anio: to_string(anio), 
                                 folio: "0001", 
                               xmlfile: encrypt(raw_file)}
  	Reception.Repo.insert(document)
  end

  def encrypt (plain_file) do
    plain_file = to_string(plain_file)
    key = "abcdefghabcdefgh"
    iv = "12345678abcdefgh"
    :crypto.aes_cfb_128_encrypt(key,iv,plain_file) 
  end

  def decrypt (secret) do 
    key = "abcdefghabcdefgh"
    iv = "12345678abcdefgh"
    result = :crypto.aes_cfb_128_decrypt(key,iv,secret)
  end

  def query(xpath, xml) do
    IO.inspect "LEYENDO PATH #{xpath}"
    [result] = :xmerl_xpath.string(xpath, xml)
    elem(result, 8)
  end

end  