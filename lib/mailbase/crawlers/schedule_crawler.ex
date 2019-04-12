defmodule Mailbase.ScheduleCrawler do
  use GenServer
  import Ecto.Query
  alias Mailbase.Schedules
  alias Mailbase.Repo
  alias Mailbase.Schedules.Schedule

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(state) do
    # Schedule work to be performed on start
    schedule_crawl
    schedule_work(1)

    {:ok, state}
  end

  def handle_cast({:add, schedules}, state) do
    new_state = schedules++state # |> IO.inspect
    {:noreply, new_state}
  end


  def handle_info(message, state) do

    case message do
      :crawl ->
        ready_schedules = Schedules.get_ready_schedules
        if (ready_schedules != []) do
          change_next_mailing_time(ready_schedules)
          GenServer.cast(self(), {:add, ready_schedules})
        end
        schedule_crawl
        {:noreply, state}
      :work ->
        if (state == []) do
          schedule_work(5000)
          {:noreply, state}
        else
          [head | tail] =  state |> IO.inspect

          # PROCESS HEAD
          IO.puts "- processing head -"

          schedule_work(1)
          {:noreply, tail}
        end
      _ ->
        IO.puts "-------- ERROR NO MATCH ------------"
        IO.puts "no match for message:"
        IO.inspect message
        IO.puts "while state:"
        IO.inspect state
        {:noreply, state}
    end
  end

  defp schedule_crawl do
    Process.send_after(self(), :crawl, 5 * 1000)
  end

  def change_next_mailing_time([head | tail]) do
    schedule = head # |> IO.inspect

    schedule_params = %{}
    |> Map.put("user_id", schedule.user_id)
    |> Map.put("last_mailing", DateTime.utc_now)
    |> Map.put("next_mailing", DateTime.add(DateTime.utc_now, 60 * 60 * 24 * schedule.schedule_time, :second))
    |> Map.put("name", schedule.name)
    |> Map.put("schedule_time", schedule.schedule_time)
    |> Map.put("email_text", schedule.email_text)
    # |> IO.inspect

    Schedules.update_schedule(schedule, schedule_params)

    change_next_mailing_time(tail)
  end

  def change_next_mailing_time([]) do
  end

  def schedule_work(time) do
    Process.send_after(self(), :work, time)
  end



end
