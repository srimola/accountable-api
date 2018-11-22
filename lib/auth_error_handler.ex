defmodule Accountable.AuthErrorHandler do
  import Plug.Conn

  def auth_error(conn, {type, reason}, _opts) do
    body = Poison.encode!(%{error: to_string(type), reason: to_string(reason)})
    send_resp(conn, 401, body)
  end
end
