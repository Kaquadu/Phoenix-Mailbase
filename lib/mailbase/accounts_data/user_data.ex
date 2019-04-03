defmodule Mailbase.AccountsData.UserData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users_data" do
    field :company_name, :string
    field :domain_name, :string
    field :hosting_mail, :string
    field :hosting_password, :string
    field :port, :integer
    field :server_name, :string

    belongs_to :user, Mailbase.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(user_data, attrs) do
    user_data
    |> cast(attrs, [:company_name, :server_name, :domain_name, :port, :hosting_mail, :hosting_password, :user_id])
  end
end
