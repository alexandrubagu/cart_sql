defmodule Cart.BasketItem do
  @moduledoc false

  use Cart.Schema

  schema "basket_items" do
    field :removed, :boolean, default: false
    belongs_to :basket, Cart.Basket
    belongs_to :category, Cart.Category
    belongs_to :product, Cart.Product
  end

  @doc false
  def changeset(basket_item, attrs) do
    basket_item
    |> cast(attrs, [:purchased, :removed])
    |> validate_required([:purchased])
  end
end
