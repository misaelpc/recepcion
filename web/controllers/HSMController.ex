defmodule Reception.HSMController do
  use Phoenix.Controller

  plug :action

  def sign_dummy(conn, _params) do

    IO.inspect _params["chain"]

  	text conn, "N4xILaxsK8hlszgLAR3AE51RULWk759rHM/U+/o1hfyJia4Yyvi3w9FUbrrvfYR3wRpLeZVEXJXYHHhSh6bVDLPqK8RdsAQbKlYWj8ZFj+bWMTWKLwjT/dSr+s1IqHoYKoM5vX866dg/Kagv7chrAWY1UwnMgFwil3XId+fS3RE="
  end

end