defmodule MailbaseWeb.AddressController do
  use MailbaseWeb, :controller

  alias Mailbase.Receivers
  alias Mailbase.Receivers.Address

  def index(conn, _params) do
    addresses = Receivers.list_addresses()
    render(conn, "index.html", addresses: addresses)
  end

  def new(conn, _params) do
    changeset = Receivers.change_address(%Address{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"address" => address_params}) do
    case Receivers.create_address(address_params) do
      {:ok, address} ->
        conn
        |> put_flash(:info, "Address created successfully.")
        |> redirect(to: Routes.address_path(conn, :show, address))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    address = Receivers.get_address!(id)
    render(conn, "show.html", address: address)
  end

  def edit(conn, %{"id" => id}) do
    address = Receivers.get_address!(id)
    changeset = Receivers.change_address(address)
    render(conn, "edit.html", address: address, changeset: changeset)
  end

  def update(conn, %{"id" => id, "address" => address_params}) do
    address = Receivers.get_address!(id)

    case Receivers.update_address(address, address_params) do
      {:ok, address} ->
        conn
        |> put_flash(:info, "Address updated successfully.")
        |> redirect(to: Routes.address_path(conn, :show, address))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", address: address, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    address = Receivers.get_address!(id)
    {:ok, _address} = Receivers.delete_address(address)

    conn
    |> put_flash(:info, "Address deleted successfully.")
    |> redirect(to: Routes.address_path(conn, :index))
  end
end
