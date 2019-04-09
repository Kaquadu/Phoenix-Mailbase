defmodule Mailbase.Schedules.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schedules" do
    field :last_mailing, :utc_datetime
    field :matching_list, :string
    field :email_text, :string
    field :name, :string
    field :schedule_time, :integer


    belongs_to :user, Mailbase.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    attrs |> IO.inspect
    schedule
    |> IO.inspect
    |> cast(attrs, [:name, :schedule_time, :last_mailing, :matching_list, :email_text, :user_id])
    |> IO.inspect
    |> validate_required([:name, :schedule_time, :last_mailing, :matching_list, :email_text, :user_id])
    |> IO.inspect
  end
end
