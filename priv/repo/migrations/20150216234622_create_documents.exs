defmodule Reception.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def up do
    "CREATE TABLE documents(id serial primary key, rfc varchar(140), timestamp varchar(140));"
  end

  def down do
    "DROP TABLE quotes;"
  end
end
