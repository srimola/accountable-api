defmodule Accountable.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :accountable,
    module: Accountable.Guardian,
    error_handler: Accountable.AuthErrorHandler

  plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
