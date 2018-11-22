defmodule AccountableWeb.CalendarController do
  use AccountableWeb, :controller

  alias Accountable.Calendars
  alias Accountable.Calendars.Calendar

  action_fallback AccountableWeb.FallbackController

  def index(conn, _params) do
    calendars = Calendars.list_calendars()
    render(conn, "index.json", calendars: calendars)
  end

  def create(conn, %{"calendar" => calendar_params}) do
    with {:ok, %Calendar{} = calendar} <- Calendars.create_calendar(calendar_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.calendar_path(conn, :show, calendar))
      |> render("show.json", calendar: calendar)
    end
  end

  def show(conn, %{"id" => id}) do
    calendar = Calendars.get_calendar!(id)
    render(conn, "show.json", calendar: calendar)
  end

  def update(conn, %{"id" => id } = calendar_params) do
    calendar = Calendars.get_calendar!(id)

    with {:ok, %Calendar{} = calendar} <- Calendars.update_calendar(calendar, calendar_params) do
      render(conn, "show.json", calendar: calendar)
    end
  end

  def delete(conn, %{"id" => id}) do
    calendar = Calendars.get_calendar!(id)

    with {:ok, %Calendar{}} <- Calendars.delete_calendar(calendar) do
      send_resp(conn, :no_content, "")
    end
  end
end
