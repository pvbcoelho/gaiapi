defmodule GaiapiWeb.Router do
  use GaiapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GaiapiWeb do
    pipe_through :api

    scope "/v1" do
      post "/request", RequestsController, :create
      get "/request/:request_id", RequestsController, :get
    end
  end
end
