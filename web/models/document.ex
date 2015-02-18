defmodule Reception.Document do
  use Ecto.Model

  schema "documents" do
    field :rfc, :binary
    field :nocertificado, :binary
    field :mes, :string
    field :anio, :string
    field :folio, :string
    field :xmlfile, :binary
  end

end  