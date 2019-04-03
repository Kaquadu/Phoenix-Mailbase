defmodule MailbaseWeb.UserDataControllerTest do
  use MailbaseWeb.ConnCase

  alias Mailbase.AccountsData

  @create_attrs %{company_name: "some company_name", domain_name: "some domain_name", hosting_mail: "some hosting_mail", hosting_password: "some hosting_password", port: 42, server_name: "some server_name"}
  @update_attrs %{company_name: "some updated company_name", domain_name: "some updated domain_name", hosting_mail: "some updated hosting_mail", hosting_password: "some updated hosting_password", port: 43, server_name: "some updated server_name"}
  @invalid_attrs %{company_name: nil, domain_name: nil, hosting_mail: nil, hosting_password: nil, port: nil, server_name: nil}

  def fixture(:user_data) do
    {:ok, user_data} = AccountsData.create_user_data(@create_attrs)
    user_data
  end

  describe "index" do
    test "lists all users_data", %{conn: conn} do
      conn = get(conn, Routes.user_data_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Users data"
    end
  end

  describe "new user_data" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_data_path(conn, :new))
      assert html_response(conn, 200) =~ "New User data"
    end
  end

  describe "create user_data" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_data_path(conn, :create), user_data: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_data_path(conn, :show, id)

      conn = get(conn, Routes.user_data_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show User data"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_data_path(conn, :create), user_data: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User data"
    end
  end

  describe "edit user_data" do
    setup [:create_user_data]

    test "renders form for editing chosen user_data", %{conn: conn, user_data: user_data} do
      conn = get(conn, Routes.user_data_path(conn, :edit, user_data))
      assert html_response(conn, 200) =~ "Edit User data"
    end
  end

  describe "update user_data" do
    setup [:create_user_data]

    test "redirects when data is valid", %{conn: conn, user_data: user_data} do
      conn = put(conn, Routes.user_data_path(conn, :update, user_data), user_data: @update_attrs)
      assert redirected_to(conn) == Routes.user_data_path(conn, :show, user_data)

      conn = get(conn, Routes.user_data_path(conn, :show, user_data))
      assert html_response(conn, 200) =~ "some updated company_name"
    end

    test "renders errors when data is invalid", %{conn: conn, user_data: user_data} do
      conn = put(conn, Routes.user_data_path(conn, :update, user_data), user_data: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User data"
    end
  end

  describe "delete user_data" do
    setup [:create_user_data]

    test "deletes chosen user_data", %{conn: conn, user_data: user_data} do
      conn = delete(conn, Routes.user_data_path(conn, :delete, user_data))
      assert redirected_to(conn) == Routes.user_data_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.user_data_path(conn, :show, user_data))
      end
    end
  end

  defp create_user_data(_) do
    user_data = fixture(:user_data)
    {:ok, user_data: user_data}
  end
end
