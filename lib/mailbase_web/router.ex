defmodule MailbaseWeb.Router do
  use MailbaseWeb, :router

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

  scope "/", MailbaseWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/welcome", UserController, :logged_in
    get "/add_rcv", ListController, :add_receiver
    resources "/user", UserController
    resources "/userdata", UserDataController, except: [:new, :create]
    resources "/list", ListController
    resources "/receivers", AddressController, except: [:show]
    resources "/schedules", ScheduleController

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/login", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", MailbaseWeb do
  #   pipe_through :api
  # end
end
