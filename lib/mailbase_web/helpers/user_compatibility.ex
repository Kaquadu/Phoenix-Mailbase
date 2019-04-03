defmodule MailbaseWeb.Helpers.UserCompatibility do
  def check_user(conn, id) do
    Kernel.inspect(conn.assigns.current_user.id) == id
  end
end
