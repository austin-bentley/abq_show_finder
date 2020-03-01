defmodule AbqShowFinderWeb.Router do
  use AbqShowFinderWeb, :router

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

  scope "/", AbqShowFinderWeb do
    pipe_through :browser

    get "/", HomeController, :index
    get "/shows", ShowsController, :show
    get "/hold-my-ticket", HoldMyTicketController, :index
  end
end
