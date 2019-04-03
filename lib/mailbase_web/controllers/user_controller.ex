defmodule MailbaseWeb.UserController do
  use MailbaseWeb, :controller

  alias Mailbase.Accounts
  alias Mailbase.Accounts.User
  alias Mailbase.AccountsData
  alias MailbaseWeb.Helpers

plug MailbaseWeb.Plugs.CheckAuth when action in [:index, :show, :edit, :logged_in]

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        add_user_data(user)
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Rejestracja przebiegła pomyślnie")
        |> redirect(to: Routes.user_path(conn, :logged_in))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    if Helpers.UserCompatibility.check_user(conn, id) do
      user = Accounts.get_user!(id)
      render(conn, "show.html", user: user)
    else
      conn
      |> put_flash(:error, "Nie masz dostępu do tych danych")
      |> redirect(to: Routes.user_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    if Helpers.UserCompatibility.check_user(conn, id) do
      user = Accounts.get_user!(id)
      changeset = Accounts.change_user(user)
      render(conn, "edit.html", user: user, changeset: changeset)
    else
      conn
      |> put_flash(:error, "Nie masz dostępu do tych danych")
      |> redirect(to: Routes.user_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Użytkownik zaktualizowany")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "Użytkownik usunięty")
    |> redirect(to: Routes.user_path(conn, :index))
  end

  def logged_in(conn, _params) do
    assigns = Map.get(conn, :assigns)
    user = assigns.current_user
    render(conn, "logged_in.html", user: user)
  end


  defp add_user_data(user) do
    AccountsData.create_user_data(%{"company_name" => nil,
                                    "domain_name" => nil,
                                    "hosting_mail" => nil,
                                    "hosting_password" => nil,
                                    "port" => nil,
                                    "server_name" => nil,
                                    "user" => user,
                                    "user_id" => user.id})
  end

end
