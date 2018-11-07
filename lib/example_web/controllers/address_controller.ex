defmodule ExampleWeb.AddressController do
  use ExampleWeb, :controller
  use Rummage.Phoenix.Controller

  alias Example
  alias Example.Address

  def index(conn, params) do
    {addresses, rummage} = Example.list_addresses(params["rummage"])
    render(conn, "index.html", addresses: addresses, rummage: rummage)
  end

  def new(conn, _params) do
    changeset = Example.change_address(%Address{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"address" => address_params}) do
    case Example.create_address(address_params) do
      {:ok, address} ->
        conn
        |> put_flash(:info, "Address created successfully.")
        |> redirect(to: Routes.address_path(conn, :show, address))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    address = Example.get_address!(id)
    render(conn, "show.html", address: address)
  end

  def edit(conn, %{"id" => id}) do
    address = Example.get_address!(id)
    changeset = Example.change_address(address)
    render(conn, "edit.html", address: address, changeset: changeset)
  end

  def update(conn, %{"id" => id, "address" => address_params}) do
    address = Example.get_address!(id)

    case Example.update_address(address, address_params) do
      {:ok, address} ->
        conn
        |> put_flash(:info, "Address updated successfully.")
        |> redirect(to: Routes.address_path(conn, :show, address))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", address: address, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    address = Example.get_address!(id)
    {:ok, _address} = Example.delete_address(address)

    conn
    |> put_flash(:info, "Address deleted successfully.")
    |> redirect(to: Routes.address_path(conn, :index))
  end
end
