defmodule Mailbase.Repo.Migrations.CreateUsersData do
  use Ecto.Migration

  def change do
    create table(:users_data) do
      add :company_name, :string
      add :server_name, :string
      add :domain_name, :string
      add :port, :integer
      add :hosting_mail, :string
      add :hosting_password, :string
      add :user_id, references(:users)

      timestamps()
    end

    create unique_index(:users_data, [:user_id])

  end
end
