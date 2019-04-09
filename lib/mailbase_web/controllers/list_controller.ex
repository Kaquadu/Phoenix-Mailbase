defmodule MailbaseWeb.ListController do
  use MailbaseWeb, :controller

  alias Mailbase.Lists
  alias Mailbase.Lists.List
  alias Mailbase.Receivers
  alias Mailbase.Receivers.Address

  plug MailbaseWeb.Plugs.CheckAuth when action in [:index, :new, :create, :update, :show, :edit, :logged_in]

  def index(conn, _params) do
    list = Lists.list_list(conn)
    render(conn, "index.html", list: list)
  end

  def new(conn, _params) do
    changeset = Lists.change_list(%List{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"list" => list_params}) do
    IO.inspect list_params = Map.put(list_params, "user_id", conn.assigns.current_user.id)
    case Lists.create_list(list_params) do
      {:ok, list} ->
        conn
        |> put_flash(:info, "List created successfully.")
        |> redirect(to: Routes.list_path(conn, :show, list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Lists.get_list!(id)
    addresses = Receivers.get_by_list_id!(id)
    render(conn, "show.html", list: list, addresses: addresses)
  end

  def edit(conn, %{"id" => id}) do
    list = Lists.get_list!(id)
    changeset = Lists.change_list(list)
    render(conn, "edit.html", list: list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Lists.get_list!(id)

    case Lists.update_list(list, list_params) do
      {:ok, list} ->
        conn
        |> put_flash(:info, "List updated successfully.")
        |> redirect(to: Routes.list_path(conn, :show, list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", list: list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Lists.get_list!(id)
    {:ok, _list} = Lists.delete_list(list)

    conn
    |> put_flash(:info, "List deleted successfully.")
    |> redirect(to: Routes.list_path(conn, :index))
  end

  def add_receiver(conn, %{"list_id" => id}) do
    conn
    |> redirect(to: Routes.address_path(conn, :new, list_id: id))
  end
end
