defmodule Reception.Document do
  use Ecto.Model

  schema "documents" do
    field :rfc, :string
    field :curp, :string
    field :calle, :string
    field :colonia, :string
    field :folio, :string
    field :xmlfile, :binary
  end

end  