defmodule Reception.PageController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def save_document(conn, _params) do
    xml = open_xml
        
    {:ok, body} = File.read("./doctodig.xml")
    rfc_emisor = query('/DD:DoctoDigital/DD:Emisor/@ERFC',xml)
    curp_emisor = query('/DD:DoctoDigital/DD:Emisor/@ECURP',xml)
    calle = query('/DD:DoctoDigital/DD:Emisor/DD:Domicilio/@ECalle',xml)
    colonia = query('/DD:DoctoDigital/DD:Emisor/DD:Domicilio/@EColonia',xml)

    secret = encrypt(rfc_emisor)
    resultado = decrypt(secret)
    IO.puts resultado

  	document = %Reception.Document{rfc: encrypt(rfc_emisor), 
                                  curp: encrypt(rfc_emisor),   
                                 calle: to_string(calle), 
                               colonia: to_string(colonia), 
                                 folio: "0001", 
                               xmlfile: encrypt(to_string(body))}
  	Reception.Repo.insert(document)
    text conn, "Guardado Exitosamente"
  end

  def encrypt (plain_file) do
    plain_file = to_string(plain_file)
    key = "abcdefghabcdefgh"
    iv = "12345678abcdefgh"

    # keysize  = bit_size(key)
    # ivsize   = bit_size(iv)
    # textsize = bit_size(text)
    #crypto = :crypto.block_encrypt(aes_ige256,key, iv, plain_file)
    :crypto.aes_cfb_128_encrypt(key,iv,plain_file) 
  end

  def decrypt (secret) do 
    key = "abcdefghabcdefgh"
    iv = "12345678abcdefgh"

    result = :crypto.aes_cfb_128_decrypt(key,iv,secret)
  end

  def open_xml do 
    {xml,_} = :xmerl_scan.file("./doctodig.xml")
    xml
  end

  def query(xpath, xml) do
    IO.inspect "LEYENDO PATH #{xpath}"
    [result] = :xmerl_xpath.string(xpath, xml)
    elem(result, 8)
  end



    # Crypt = crypto:aes_cfb_128_encrypt(Key, IV, Text),
    # io:format("Crypt is ~p~n", [Crypt]),

    # Decrypt = crypto:aes_cfb_128_decrypt(Key, IV, Crypt),
    # io:format("Decrypt is ~p~n", [Decrypt]),

end
