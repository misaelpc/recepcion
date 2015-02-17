defmodule Reception.Document do
  use Ecto.Model

  schema "documents" do
    field :rfc, :string
    field :nocertificado, :string
    field :mes, :string
    field :anio, :string
    field :folio, :string
    field :xmlfile, :binary
  end

end  