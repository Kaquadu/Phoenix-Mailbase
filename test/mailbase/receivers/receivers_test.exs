defmodule Mailbase.ReceiversTest do
  use Mailbase.DataCase

  alias Mailbase.Receivers

  describe "addresses" do
    alias Mailbase.Receivers.Address

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Receivers.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Receivers.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Receivers.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Receivers.create_address(@valid_attrs)
      assert address.email == "some email"
      assert address.name == "some name"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Receivers.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Receivers.update_address(address, @update_attrs)
      assert address.email == "some updated email"
      assert address.name == "some updated name"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Receivers.update_address(address, @invalid_attrs)
      assert address == Receivers.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Receivers.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Receivers.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Receivers.change_address(address)
    end
  end
end
