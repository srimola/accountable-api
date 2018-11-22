defmodule AccountableWeb.CalendarControllerTest do
  use AccountableWeb.ConnCase

  alias Accountable.Calendars
  alias Accountable.Calendars.Calendar

  @create_attrs %{
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:calendar) do
    {:ok, calendar} = Calendars.create_calendar(@create_attrs)
    calendar
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all calendars", %{conn: conn} do
      conn = get(conn, Routes.calendar_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create calendar" do
    test "renders calendar when data is valid", %{conn: conn} do
      conn = post(conn, Routes.calendar_path(conn, :create), calendar: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.calendar_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.calendar_path(conn, :create), calendar: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update calendar" do
    setup [:create_calendar]

    test "renders calendar when data is valid", %{conn: conn, calendar: %Calendar{id: id} = calendar} do
      conn = put(conn, Routes.calendar_path(conn, :update, calendar), calendar: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.calendar_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, calendar: calendar} do
      conn = put(conn, Routes.calendar_path(conn, :update, calendar), calendar: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete calendar" do
    setup [:create_calendar]

    test "deletes chosen calendar", %{conn: conn, calendar: calendar} do
      conn = delete(conn, Routes.calendar_path(conn, :delete, calendar))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.calendar_path(conn, :show, calendar))
      end
    end
  end

  defp create_calendar(_) do
    calendar = fixture(:calendar)
    {:ok, calendar: calendar}
  end
end
