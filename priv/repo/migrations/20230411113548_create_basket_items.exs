defmodule Cart.Repo.Migrations.CreateBasketItems do
  use Ecto.Migration

  def change do
    create table(:basket_items) do
      add :removed, :boolean, default: false, null: false
      add :basket_id, references(:baskets, on_delete: :nothing), primary_key: true, null: false
      add :category_id, references(:categories, on_delete: :nothing), null: false
      add :product_id, references(:products, on_delete: :nothing), null: false
    end

    create index(:basket_items, [:basket_id], where: "removed is FALSE")

    create index(:basket_items, [:category_id, :product_id],
             include: [:basket_id],
             where: "removed is FALSE"
           )
  end
end
