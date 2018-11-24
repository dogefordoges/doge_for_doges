defmodule DogeForDogesWeb.Router do
  use DogeForDogesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DogeForDogesWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", DogeForDogesWeb do
    pipe_through :api

    resources "/users", UserController
    resources "/transactions", TransactionController
  end
end
