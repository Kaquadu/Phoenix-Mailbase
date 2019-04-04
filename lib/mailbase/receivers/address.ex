defmodule Mailbase.Receivers.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :email, :string
    field :name, :string
    field :list_id, :integer

    belongs_to :lists, Mailbase.Accounts.List
    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:name, :email, :list_id])
    |> validate_required([:name, :email, :list_id])
    |> validate_format(:email, ~r/@/)
  end
end
