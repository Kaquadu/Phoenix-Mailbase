defmodule MailbaseWeb.ScheduleController do
  use MailbaseWeb, :controller

  alias Mailbase.Schedules
  alias Mailbase.Schedules.Schedule
  alias Mailbase.Lists
  alias Mailbase.Lists.List

  plug MailbaseWeb.Plugs.CheckAuth when action in [:index, :new, :create, :update, :show, :edit, :logged_in]

  def index(conn, _params) do
    schedules = Schedules.list_schedules()
    render(conn, "index.html", schedules: schedules)
  end

  def new(conn, _params) do
    changeset = Schedules.change_schedule(%Schedule{})
    list_names = Lists.get_user_list_names(conn.assigns.current_user.id)
    render(conn, "new.html", changeset: changeset, list_names: list_names)
  end

  def create(conn, %{"schedule" => schedule_params}) do
    case Schedules.create_schedule(schedule_params) do
      {:ok, schedule} ->
        conn
        |> put_flash(:info, "Schedule created successfully.")
        |> redirect(to: Routes.schedule_path(conn, :show, schedule))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    schedule = Schedules.get_schedule!(id)
    render(conn, "show.html", schedule: schedule)
  end

  def edit(conn, %{"id" => id}) do
    schedule = Schedules.get_schedule!(id)
    changeset = Schedules.change_schedule(schedule)
    render(conn, "edit.html", schedule: schedule, changeset: changeset)
  end

  def update(conn, %{"id" => id, "schedule" => schedule_params}) do
    schedule = Schedules.get_schedule!(id)

    case Schedules.update_schedule(schedule, schedule_params) do
      {:ok, schedule} ->
        conn
        |> put_flash(:info, "Schedule updated successfully.")
        |> redirect(to: Routes.schedule_path(conn, :show, schedule))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", schedule: schedule, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    schedule = Schedules.get_schedule!(id)
    {:ok, _schedule} = Schedules.delete_schedule(schedule)

    conn
    |> put_flash(:info, "Schedule deleted successfully.")
    |> redirect(to: Routes.schedule_path(conn, :index))
  end
end
