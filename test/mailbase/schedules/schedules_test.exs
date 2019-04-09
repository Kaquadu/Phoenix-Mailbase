defmodule Mailbase.SchedulesTest do
  use Mailbase.DataCase

  alias Mailbase.Schedules

  describe "schedules" do
    alias Mailbase.Schedules.Schedule

    @valid_attrs %{last_mailing: "2010-04-17T14:00:00Z", matching_list_id: 42, name: "some name", schedule_time: 42}
    @update_attrs %{last_mailing: "2011-05-18T15:01:01Z", matching_list_id: 43, name: "some updated name", schedule_time: 43}
    @invalid_attrs %{last_mailing: nil, matching_list_id: nil, name: nil, schedule_time: nil}

    def schedule_fixture(attrs \\ %{}) do
      {:ok, schedule} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedules.create_schedule()

      schedule
    end

    test "list_schedules/0 returns all schedules" do
      schedule = schedule_fixture()
      assert Schedules.list_schedules() == [schedule]
    end

    test "get_schedule!/1 returns the schedule with given id" do
      schedule = schedule_fixture()
      assert Schedules.get_schedule!(schedule.id) == schedule
    end

    test "create_schedule/1 with valid data creates a schedule" do
      assert {:ok, %Schedule{} = schedule} = Schedules.create_schedule(@valid_attrs)
      assert schedule.last_mailing == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert schedule.matching_list_id == 42
      assert schedule.name == "some name"
      assert schedule.schedule_time == 42
    end

    test "create_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedules.create_schedule(@invalid_attrs)
    end

    test "update_schedule/2 with valid data updates the schedule" do
      schedule = schedule_fixture()
      assert {:ok, %Schedule{} = schedule} = Schedules.update_schedule(schedule, @update_attrs)
      assert schedule.last_mailing == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert schedule.matching_list_id == 43
      assert schedule.name == "some updated name"
      assert schedule.schedule_time == 43
    end

    test "update_schedule/2 with invalid data returns error changeset" do
      schedule = schedule_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedules.update_schedule(schedule, @invalid_attrs)
      assert schedule == Schedules.get_schedule!(schedule.id)
    end

    test "delete_schedule/1 deletes the schedule" do
      schedule = schedule_fixture()
      assert {:ok, %Schedule{}} = Schedules.delete_schedule(schedule)
      assert_raise Ecto.NoResultsError, fn -> Schedules.get_schedule!(schedule.id) end
    end

    test "change_schedule/1 returns a schedule changeset" do
      schedule = schedule_fixture()
      assert %Ecto.Changeset{} = Schedules.change_schedule(schedule)
    end
  end
end
