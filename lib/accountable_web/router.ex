defmodule AccountableWeb.Router do
  use AccountableWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AccountableWeb do
    pipe_through :api

    resources("/users", UserController, execpt: [:new, :edit])
  end
end
