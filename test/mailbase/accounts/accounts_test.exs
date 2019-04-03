defmodule Mailbase.AccountsTest do
  use Mailbase.DataCase

  alias Mailbase.Accounts

  describe "users" do
    alias Mailbase.Accounts.User

    @valid_attrs %{host_mail: "some host_mail", host_password: "some host_password", login_mail: "some login_mail", login_password: "some login_password"}
    @update_attrs %{host_mail: "some updated host_mail", host_password: "some updated host_password", login_mail: "some updated login_mail", login_password: "some updated login_password"}
    @invalid_attrs %{host_mail: nil, host_password: nil, login_mail: nil, login_password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.host_mail == "some host_mail"
      assert user.host_password == "some host_password"
      assert user.login_mail == "some login_mail"
      assert user.login_password == "some login_password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.host_mail == "some updated host_mail"
      assert user.host_password == "some updated host_password"
      assert user.login_mail == "some updated login_mail"
      assert user.login_password == "some updated login_password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
