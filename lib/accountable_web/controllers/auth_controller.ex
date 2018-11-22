defmodule AccountableWeb.AuthenticationController do
  use AccountableWeb, :controller

  alias Accountable.Accounts

  plug Ueberauth

  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    email = auth.uid
    password = auth.credentials.other.password
    handle_user_conn(Accounts.email_password_auth(email, password), conn)
  end

  def handle_user_conn(user, conn) do
    case user do
      {:ok, user} ->
        {:ok, jwt, _claims} = Accountable.Guardian.encode_and_sign(user, %{})

        conn
        |> put_resp_header("Authorization", "Bearer #{jwt}")
        |> json(%{data: %{token: jwt}})

        # Handle error
        {:error, _reason} ->
          conn
          |> put_status(401)
          |> json(%{message: "user not found"})
    end
  end
end
