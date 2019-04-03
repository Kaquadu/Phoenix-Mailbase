defmodule MailbaseWeb.UserDataController do
  use MailbaseWeb, :controller

  alias Mailbase.AccountsData
  alias Mailbase.AccountsData.UserData
  alias MailbaseWeb.Helpers

  plug MailbaseWeb.Plugs.CheckAuth when action in [:index, :show, :edit]

  def index(conn, _params) do
    users_data = AccountsData.list_users_data()
    render(conn, "index.html", users_data: users_data)
  end

  # def new(conn, _params) do
  #   changeset = AccountsData.change_user_data(%UserData{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"user_data" => user_data_params}) do
  #   case AccountsData.create_user_data(user_data_params) do
  #     {:ok, user_data} ->
  #       conn
  #       |> put_flash(:info, "User data created successfully.")
  #       |> redirect(to: Routes.user_data_path(conn, :show, user_data))
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    if Helpers.UserCompatibility.check_user(conn, id) do
      user_data = AccountsData.get_user_data!(id)
      render(conn, "show.html", user_data: user_data)
    else
      conn
      |> put_flash(:error, "Nie masz dostępu do tych danych")
      |> redirect(to: Routes.user_data_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    if Helpers.UserCompatibility.check_user(conn, id) do
      user_data = AccountsData.get_user_data!(id)
      changeset = AccountsData.change_user_data(user_data)
      render(conn, "edit.html", user_data: user_data, user: conn.assigns.current_user, changeset: changeset)
    else
      conn
      |> put_flash(:error, "Nie masz dostępu do tych danych")
      |> redirect(to: Routes.user_data_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "user_data" => user_data_params}) do
    user_data = AccountsData.get_user_data!(id)

    case AccountsData.update_user_data(user_data, user_data_params) do
      {:ok, user_data} ->
        conn
        |> put_flash(:info, "User data updated successfully.")
        |> redirect(to: Routes.user_data_path(conn, :show, user_data))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_data: user_data, changeset: changeset)
    end
  end

  # def delete(conn, %{"id" => id}) do
  #   user_data = AccountsData.get_user_data!(id)
  #   {:ok, _user_data} = AccountsData.delete_user_data(user_data)
  #
  #   conn
  #   |> put_flash(:info, "User data deleted successfully.")
  #   |> redirect(to: Routes.user_data_path(conn, :index))
  # end
end
