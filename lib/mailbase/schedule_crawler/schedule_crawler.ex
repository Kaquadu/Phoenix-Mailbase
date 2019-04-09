defmodule Mailbase.ScheduleCrawler do
  use GenServer
  alias Mailbase.Schedules

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    # Schedule work to be performed on start
    schedule_work()

    {:ok, state}
  end

  @impl true
  def handle_info(:crawl, state) do
    # Do the desired work here
    #IO.puts Schedules.list_schedules

    # Reschedule once more
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    # In 2 hours
    Process.send_after(self(), :crawl, 5 * 1000)
  end

end
