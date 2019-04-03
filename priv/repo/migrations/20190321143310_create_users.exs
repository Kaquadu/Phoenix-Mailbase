defmodule Mailbase.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login_mail, :string
      add :login_password, :string

      timestamps()
    end

    create unique_index(:users, [:login_mail])


  end
end
