defmodule SuseWeb.UrlController do
  use SuseWeb, :controller

  alias Suse.Urls

  def index(conn, _) do
    changeset = Urls.change()
    render(conn, "index.html", changeset: changeset, display: nil)
  end

  def create(conn, url_params) do
    case Urls.create(url_params) do
      {:ok, url} ->
        redirect(conn, to: Routes.url_path(conn, :show, url))

      {:error, _} ->
        render(conn, "index.html", display: "Please enter a valid URL")
    end
  end

  def show(conn, %{"id" => id}) do
    case Urls.get(id) do
      nil ->
        conn
        |> put_flash(:error, "Url not found")
        |> redirect(to: Routes.url_path(conn, :index))

      url ->
        render(conn, "show.html", url: url)
    end
  end

  def redirect_by_slug(conn, %{"slug" => slug}) do
    case Urls.get_by_slug(slug) do
      {:ok, url} ->
        redirect(conn, external: url.long_url)

      {:error, :url_not_found} ->
        redirect(conn, to: Routes.url_path(conn, :index))
    end
  end
end
