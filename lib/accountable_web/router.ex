defmodule AccountableWeb.Router do
  use AccountableWeb, :router
  alias Accountable.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug(Guardian.AuthPipeline)
  end

  scope "/api/v1", AccountableWeb do
    pipe_through([:api, :jwt_authenticated])

    resources "/calendars", CalendarController, except: [:new, :edit]
  end

  scope "/api/v1", AccountableWeb do
    pipe_through :api

    resources("/users", UserController, only: [:index, :show])
    post("/auth/register", UserController, :create)
    post("/auth/login", UserController, :login)
  end
end
