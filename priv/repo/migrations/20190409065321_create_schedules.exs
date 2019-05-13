defmodule Mailbase.Repo.Migrations.CreateSchedules do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :name, :string
      add :schedule_time, :integer
      add :last_mailing, :utc_datetime
      add :next_mailing, :utc_datetime
      add :matching_list, :string
      add :email_title, :text
      add :email_text, :text
      add :user_id, references(:users)

      timestamps()
    end

    create unique_index(:schedules, [:name])
  end
end
