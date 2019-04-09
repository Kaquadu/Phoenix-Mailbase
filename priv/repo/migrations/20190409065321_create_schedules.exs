defmodule Mailbase.Repo.Migrations.CreateSchedules do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :name, :string
      add :schedule_time, :integer
      add :last_mailing, :utc_datetime
      add :matching_list, :string
      add :email_text, :text
      add :user_id, references(:users)

      timestamps()
    end

  end
end
