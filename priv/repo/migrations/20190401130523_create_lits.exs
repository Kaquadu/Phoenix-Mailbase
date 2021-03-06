defmodule Mailbase.Repo.Migrations.CreateLits do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :name, :string
      add :desc, :text
      add :user_id, references(:users)

      timestamps()
    end

  end
end
