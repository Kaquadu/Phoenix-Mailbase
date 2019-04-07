defmodule Mailbase.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :name, :string
      add :email, :string
      add :list_id, references(:lists)

      timestamps()
    end

  end
end
