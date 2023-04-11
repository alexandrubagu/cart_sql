defmodule Cart.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, null: false
      add :category_id, references(:categories, on_delete: :nothing), null: false
    end

    create(unique_index(:products, [:name]))
  end
end
