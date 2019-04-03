defmodule MailbaseWeb.Plugs.CheckAuth do
  use MailbaseWeb, :controller
  import Plug.Conn
  alias Mailbase.Accounts
  alias Mailbase.Accounts.User
  alias Mailbase.AccountsData

  def call(%Plug.Conn{} = conn, _params) do
    check_auth(conn)
  end

  defp check_auth(conn) do
    if user_id = get_session(conn, :current_user_id) do
      current_user = Accounts.get_user!(user_id)

      conn
      |> assign(:current_user, current_user)
    else
      conn
      |> put_flash(:error, "Musisz być zalogowany aby mieć dostęp do tego zasobu")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
