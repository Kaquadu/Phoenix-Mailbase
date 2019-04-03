defmodule Mailbase.AccountsDataTest do
  use Mailbase.DataCase

  alias Mailbase.AccountsData

  describe "users_data" do
    alias Mailbase.AccountsData.UserData

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_data_fixture(attrs \\ %{}) do
      {:ok, user_data} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AccountsData.create_user_data()

      user_data
    end

    test "list_users_data/0 returns all users_data" do
      user_data = user_data_fixture()
      assert AccountsData.list_users_data() == [user_data]
    end

    test "get_user_data!/1 returns the user_data with given id" do
      user_data = user_data_fixture()
      assert AccountsData.get_user_data!(user_data.id) == user_data
    end

    test "create_user_data/1 with valid data creates a user_data" do
      assert {:ok, %UserData{} = user_data} = AccountsData.create_user_data(@valid_attrs)
    end

    test "create_user_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AccountsData.create_user_data(@invalid_attrs)
    end

    test "update_user_data/2 with valid data updates the user_data" do
      user_data = user_data_fixture()
      assert {:ok, %UserData{} = user_data} = AccountsData.update_user_data(user_data, @update_attrs)
    end

    test "update_user_data/2 with invalid data returns error changeset" do
      user_data = user_data_fixture()
      assert {:error, %Ecto.Changeset{}} = AccountsData.update_user_data(user_data, @invalid_attrs)
      assert user_data == AccountsData.get_user_data!(user_data.id)
    end

    test "delete_user_data/1 deletes the user_data" do
      user_data = user_data_fixture()
      assert {:ok, %UserData{}} = AccountsData.delete_user_data(user_data)
      assert_raise Ecto.NoResultsError, fn -> AccountsData.get_user_data!(user_data.id) end
    end

    test "change_user_data/1 returns a user_data changeset" do
      user_data = user_data_fixture()
      assert %Ecto.Changeset{} = AccountsData.change_user_data(user_data)
    end
  end

  describe "users_data" do
    alias Mailbase.AccountsData.UserData

    @valid_attrs %{company_name: "some company_name", domain_name: "some domain_name", hosting_mail: "some hosting_mail", hosting_password: "some hosting_password", port: 42, server_name: "some server_name"}
    @update_attrs %{company_name: "some updated company_name", domain_name: "some updated domain_name", hosting_mail: "some updated hosting_mail", hosting_password: "some updated hosting_password", port: 43, server_name: "some updated server_name"}
    @invalid_attrs %{company_name: nil, domain_name: nil, hosting_mail: nil, hosting_password: nil, port: nil, server_name: nil}

    def user_data_fixture(attrs \\ %{}) do
      {:ok, user_data} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AccountsData.create_user_data()

      user_data
    end

    test "list_users_data/0 returns all users_data" do
      user_data = user_data_fixture()
      assert AccountsData.list_users_data() == [user_data]
    end

    test "get_user_data!/1 returns the user_data with given id" do
      user_data = user_data_fixture()
      assert AccountsData.get_user_data!(user_data.id) == user_data
    end

    test "create_user_data/1 with valid data creates a user_data" do
      assert {:ok, %UserData{} = user_data} = AccountsData.create_user_data(@valid_attrs)
      assert user_data.company_name == "some company_name"
      assert user_data.domain_name == "some domain_name"
      assert user_data.hosting_mail == "some hosting_mail"
      assert user_data.hosting_password == "some hosting_password"
      assert user_data.port == 42
      assert user_data.server_name == "some server_name"
    end

    test "create_user_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AccountsData.create_user_data(@invalid_attrs)
    end

    test "update_user_data/2 with valid data updates the user_data" do
      user_data = user_data_fixture()
      assert {:ok, %UserData{} = user_data} = AccountsData.update_user_data(user_data, @update_attrs)
      assert user_data.company_name == "some updated company_name"
      assert user_data.domain_name == "some updated domain_name"
      assert user_data.hosting_mail == "some updated hosting_mail"
      assert user_data.hosting_password == "some updated hosting_password"
      assert user_data.port == 43
      assert user_data.server_name == "some updated server_name"
    end

    test "update_user_data/2 with invalid data returns error changeset" do
      user_data = user_data_fixture()
      assert {:error, %Ecto.Changeset{}} = AccountsData.update_user_data(user_data, @invalid_attrs)
      assert user_data == AccountsData.get_user_data!(user_data.id)
    end

    test "delete_user_data/1 deletes the user_data" do
      user_data = user_data_fixture()
      assert {:ok, %UserData{}} = AccountsData.delete_user_data(user_data)
      assert_raise Ecto.NoResultsError, fn -> AccountsData.get_user_data!(user_data.id) end
    end

    test "change_user_data/1 returns a user_data changeset" do
      user_data = user_data_fixture()
      assert %Ecto.Changeset{} = AccountsData.change_user_data(user_data)
    end
  end
end
