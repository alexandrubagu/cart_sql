defmodule Cart.User do
  use Cart.Schema

  schema "users" do
    field :name, :string
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
