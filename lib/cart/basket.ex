defmodule Cart.Basket do
  @moduledoc false

  use Cart.Schema

  schema "baskets" do
    field :purchased, :boolean, default: false
    belongs_to :user, Cart.User

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(basket, attrs) do
    basket
    |> cast(attrs, [])
    |> validate_required([])
  end
end
