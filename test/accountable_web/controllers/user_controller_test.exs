defmodule AccountableWeb.UserControllerTest do
  use AccountableWeb.ConnCase

  alias Accountable.Accounts
  alias Accountable.Accounts.User

  @create_attributes %{email: "email@email.com", password: "password", is_active: true}
  @update_attributes %{email: "email@email.com", is_active: false}
  @invalid_attributes %{email: nil, is_active: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(:user)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "register user" do
    test "returns user & jwt when valid" do

    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
