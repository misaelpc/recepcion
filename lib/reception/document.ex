defmodule Document do
  use Ecto.Model

  schema "documents" do
    field :rfc
    field :timestamp
  end

# rfc, timestamp, y un par de datos BLOB para guardar XMLs
# donde uno sea para el documento y otro para el acuse
# a lo mejor otro más para el folio y el tipo de documento)
# y que esos blobs sean encriptados usando el feature de Postgres
end