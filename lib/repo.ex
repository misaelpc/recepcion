defmodule Reception.Repo do
  use Ecto.Repo,
    adapter: Ecto.Adapters.Postgres,
    otp_app: :reception

  def priv do
    app_dir(:reception, "priv/repo")
  end
end
