defmodule SuseWeb.PageController do
  use SuseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
