defmodule Cart.Product do
  @moduledoc false
  use Cart.Schema

  schema "products" do
    field :name, :string

    belongs_to :category, Cart.Category
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
