defmodule Mailbase.Schedules.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schedules" do
    field :last_mailing, :utc_datetime
    field :matching_list_id, :integer
    field :name, :string
    field :schedule_time, :integer


    belongs_to :user, Mailbase.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:name, :schedule_time, :last_mailing, :matching_list_id, :user_id])
    |> validate_required([:name, :schedule_time, :last_mailing, :matching_list_id, :user_id])
  end
end
