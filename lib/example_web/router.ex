defmodule ExampleWeb.Router do
  use ExampleWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  get "/healthz", ExampleWeb.HealthController, :healthz

  scope "/", ExampleWeb do
    pipe_through :browser

    get "/ql", AddressController, :ql
    resources "/", AddressController
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: ExampleWeb.Schema

    forward "/", Absinthe.Plug, schema: ExampleWeb.Schema
  end
end
