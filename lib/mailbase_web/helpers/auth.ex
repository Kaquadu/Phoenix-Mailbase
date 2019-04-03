defmodule MailbaseWeb.Helpers.Auth do
  alias Mailbase.Repo
  alias Mailbase.Accounts.User
  alias Plug.Conn
  def signed_in?(conn) do
    user_id = Conn.get_session(conn, :current_user_id)
    if user_id, do: Repo.get(User, user_id)
  end
end
