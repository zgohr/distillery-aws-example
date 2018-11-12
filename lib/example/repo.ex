defmodule Example.Repo do
  use Ecto.Repo,
    otp_app: :distillery_example,
    adapter: Ecto.Adapters.Postgres

  import Ecto.Query

  def paginate(query, offset, limit) do
    from(r in query, offset: ^offset, limit: ^limit)
  end

  def count(query) do
    one(from(r in query, select: count("*")))
  end
end
