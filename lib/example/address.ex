defmodule Example.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :address, :string
    field :city, :string
    field :name, :string
    field :state, :string

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:name, :address, :city, :state])
    |> validate_required([:name, :address, :city, :state])
  end
end
