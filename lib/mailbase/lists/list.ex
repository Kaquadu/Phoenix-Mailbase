defmodule Mailbase.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list" do
    field :name, :string
    field :desc, :string

    belongs_to :user, Mailbase.Accounts.User
    has_many :addresses, Mailbase.Lists.Address, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :desc, :user_id])
    |> validate_required([:name])
  end
end
