# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DistilleryAwsExample.Repo.insert!(%DistilleryAwsExample.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Example.Repo
alias Example.Address

Faker.start()

Repo.delete_all(Address)

for _ <- 1..100 do
    Repo.insert!(
        %Address{
            name: Faker.Name.name(),
            address: Faker.Address.street_address(),
            city: Faker.Address.city(),
            state: Faker.Address.state(),
        }
    )
end)