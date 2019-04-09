defmodule MailbaseWeb.ScheduleControllerTest do
  use MailbaseWeb.ConnCase

  alias Mailbase.Schedules

  @create_attrs %{last_mailing: "2010-04-17T14:00:00Z", matching_list_id: 42, name: "some name", schedule_time: 42}
  @update_attrs %{last_mailing: "2011-05-18T15:01:01Z", matching_list_id: 43, name: "some updated name", schedule_time: 43}
  @invalid_attrs %{last_mailing: nil, matching_list_id: nil, name: nil, schedule_time: nil}

  def fixture(:schedule) do
    {:ok, schedule} = Schedules.create_schedule(@create_attrs)
    schedule
  end

  describe "index" do
    test "lists all schedules", %{conn: conn} do
      conn = get(conn, Routes.schedule_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Schedules"
    end
  end

  describe "new schedule" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.schedule_path(conn, :new))
      assert html_response(conn, 200) =~ "New Schedule"
    end
  end

  describe "create schedule" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.schedule_path(conn, :create), schedule: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.schedule_path(conn, :show, id)

      conn = get(conn, Routes.schedule_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Schedule"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.schedule_path(conn, :create), schedule: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Schedule"
    end
  end

  describe "edit schedule" do
    setup [:create_schedule]

    test "renders form for editing chosen schedule", %{conn: conn, schedule: schedule} do
      conn = get(conn, Routes.schedule_path(conn, :edit, schedule))
      assert html_response(conn, 200) =~ "Edit Schedule"
    end
  end

  describe "update schedule" do
    setup [:create_schedule]

    test "redirects when data is valid", %{conn: conn, schedule: schedule} do
      conn = put(conn, Routes.schedule_path(conn, :update, schedule), schedule: @update_attrs)
      assert redirected_to(conn) == Routes.schedule_path(conn, :show, schedule)

      conn = get(conn, Routes.schedule_path(conn, :show, schedule))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, schedule: schedule} do
      conn = put(conn, Routes.schedule_path(conn, :update, schedule), schedule: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Schedule"
    end
  end

  describe "delete schedule" do
    setup [:create_schedule]

    test "deletes chosen schedule", %{conn: conn, schedule: schedule} do
      conn = delete(conn, Routes.schedule_path(conn, :delete, schedule))
      assert redirected_to(conn) == Routes.schedule_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.schedule_path(conn, :show, schedule))
      end
    end
  end

  defp create_schedule(_) do
    schedule = fixture(:schedule)
    {:ok, schedule: schedule}
  end
end
