defmodule CartWeb.PageController do
  use CartWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
