defmodule Reception.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def up do
    "CREATE TABLE documents(id serial primary key,rfc bytea,noCertificado bytea,mes varchar(140),anio varchar(140),folio varchar(140),xmlfile bytea);"
  end

  def down do
    "DROP TABLE documents;"
  end
end
