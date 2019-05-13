defmodule Mailbase.Schedules.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schedules" do
    field :last_mailing, :utc_datetime
    field :next_mailing, :utc_datetime
    field :matching_list, :string
    field :email_title, :string
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
    |> cast(attrs, [:name, :schedule_time, :last_mailing, :next_mailing, :matching_list, :email_title, :email_text, :user_id])
    |> validate_required([:name, :schedule_time, :last_mailing, :next_mailing, :matching_list, :email_title, :email_text, :user_id])
  end
end
