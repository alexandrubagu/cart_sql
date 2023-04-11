defmodule Cart.Repo.Migrations.CreateBaskets do
  use Ecto.Migration

  def change do
    create table(:baskets) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :purchased, :boolean, default: false, null: false

      timestamps(updated_at: false)
    end

    create index(:baskets, [:user_id], where: "purchased is TRUE")
  end
end
