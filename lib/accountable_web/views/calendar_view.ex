defmodule AccountableWeb.CalendarView do
  use AccountableWeb, :view
  alias AccountableWeb.CalendarView

  def render("index.json", %{calendars: calendars}) do
    %{data: render_many(calendars, CalendarView, "calendar.json")}
  end

  def render("show.json", %{calendar: calendar}) do
    %{data: render_one(calendar, CalendarView, "calendar.json")}
  end

  def render("calendar.json", %{calendar: calendar}) do
    %{id: calendar.id,
      name: calendar.name,
      description: calendar.description}
  end
end
