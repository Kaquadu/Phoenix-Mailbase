defmodule Mailbase.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list" do
    field :name, :string


    belongs_to :user, Mailbase.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name])
  end
end
