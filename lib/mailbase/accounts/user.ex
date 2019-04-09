defmodule Mailbase.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :login_mail, :string
    field :login_password, :string

    has_one :user_data, Mailbase.AccountsData.UserData, on_delete: :delete_all
    has_many :lists, Mailbase.Lists.List, on_delete: :delete_all
    has_many :schedules, Mailbase.Schedules.Schedule, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:login_mail, :login_password])
    |> validate_required([:login_mail, :login_password])
    |> unique_constraint(:login_mail)
    |> validate_format(:login_mail, ~r/@/)
    |> validate_length(:login_password, min: 8, max: 16)
    |> update_change(:login_password, &Bcrypt.hash_pwd_salt/1)
  end
end
