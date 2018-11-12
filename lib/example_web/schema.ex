defmodule ExampleWeb.Schema do
  use Absinthe.Schema

  require Ecto.Query
  alias Example.Repo

  object(:address) do
    field(:id, non_null(:id))
    field(:address, non_null(:string))
    field(:city, non_null(:string))
    field(:name, non_null(:string))
    field(:state, non_null(:string))
  end

  query do
    field :addresses, list_of(:address) do
      arg(:offset, :integer, default_value: 0)
      arg(:limit, :integer, default_value: 5)

      # Resolver
      resolve(fn args, _ ->
        addresses =
          Example.Address
          |> Ecto.Query.order_by(desc: :inserted_at)
          |> Repo.paginate(args[:offset], args[:limit])
          |> Repo.all()

        {:ok, addresses}
      end)
    end

    field :addresses_count, :integer do
      # Resolver
      resolve(fn _args, _ ->
        recipes_count =
          Example.Address
          |> Repo.count()

        {:ok, recipes_count}
      end)
    end
  end
end
