config = %{
  users_number: 1_000,
  categories_number: 10_000,
  product_number: 1_000_000,
  basket_number: 1_000_000,
  items_per_basket: 4
}

[
  """
    INSERT INTO users (name)
    SELECT concat('User-', i)
    FROM generate_series(1, 1000) AS i
  """,
  """
    INSERT INTO categories (name)
    SELECT concat('Category-', i)
    FROM generate_series(1, #{config.categories_number}) AS i;
  """,
  """
    INSERT INTO products (name, category_id)
    SELECT concat('Product-', i), floor(random() * #{config.users_number} + 1)
    FROM generate_series(1, #{config.product_number}) AS i;
  """,
  """
    INSERT INTO baskets (user_id, purchased, inserted_at)
    SELECT
      floor(random() * #{config.users_number} + 1),
      random() > 0.5,
      timestamp '2023-01-01' + (random() * (timestamp '2023-12-31' - timestamp '2023-01-01'))
    FROM generate_series(1, #{config.basket_number}) AS i;
  """,
  """
    WITH basket_and_products AS (
      SELECT b.id AS basket_id, t.product_id FROM baskets b
      JOIN LATERAL (
        SELECT floor(random() * 1000000 + 1)::int AS product_id FROM generate_series(1, #{config.items_per_basket})
      ) AS t ON true
    ),
    basket_products_and_categories AS (
      SELECT random() > 0.5 as removed, bp.basket_id, p.category_id, bp.product_id
      FROM basket_and_products bp
      JOIN products p ON p.id = bp.product_id
    )
    INSERT INTO basket_items(removed, basket_id, product_id, category_id)
    SELECT removed, basket_id, product_id, category_id FROM basket_products_and_categories;
  """
]
|> Enum.each(&Cart.Repo.query(&1, [], timeout: :infinity))
