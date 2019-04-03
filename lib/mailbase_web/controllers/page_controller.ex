defmodule MailbaseWeb.PageController do
  use MailbaseWeb, :controller

  alias Mailbase.Accounts
  alias Mailbase.Accounts.User

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, _params) do
    render(conn, "login.html")
  end
end
