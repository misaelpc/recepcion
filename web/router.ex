defmodule Reception.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  #pipeline :api do
    #plug :accepts, ~w(json)
  #end

  pipeline :api do
    plug :accepts, ~w(xml)
  end

  scope "/", Reception do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    
  end

  # Other scopes may use custom stacks.
   scope "/api", Reception do
     pipe_through :api

    post "/validar", ValidatorController, :validate
   end
end
