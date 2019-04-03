defmodule MailbaseWeb.SessionController do
  use MailbaseWeb, :controller
  alias Mailbase.Accounts

   def new(conn, _params) do
     render(conn, "login.html")
   end

   def create(conn, %{"session" => auth_params}) do
     user = Accounts.get_by_email(auth_params["login_email"])
     case Bcrypt.verify_pass(auth_params["login_password"], user.login_password) do
       true ->
         conn
         |> put_session(:current_user_id, user.id)
         |> put_flash(:info, "Zalogowano pomyślnie")
         |> redirect(to: Routes.user_path(conn, :logged_in))

        false ->
          conn
          |> put_flash(:error, "Nieprawidłowe dane logowania")
          |> render("login.html")
     end

   end

   def delete(conn, _params) do
     conn
     |> delete_session(:current_user_id)
     |> put_flash(:info, "Wylogowano")
     |> redirect(to: Routes.page_path(conn, :index))
   end
end
