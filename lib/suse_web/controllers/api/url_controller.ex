defmodule SuseWeb.Api.UrlController do
  use SuseWeb, :controller
  alias Suse.Urls

  def create(conn, %{"long_url" => ""}) do
    conn
    |> put_status(400)
    |> render("create.json", error: "URL can't be empty")
  end

  def create(conn, params) do
    case Urls.create(params) do
      {:ok, url} ->
        render(conn, "create.json", url: url)

      {:error, %Ecto.Changeset{errors: errors}} ->
        reason = pull_out_only_reasonable_error_message(errors)

        conn
        |> put_status(400)
        |> render("create.json", error: reason)
    end
  end

  defp pull_out_only_reasonable_error_message(errors) do
    errors
    |> Keyword.get(:long_url)
    |> elem(0)
  end
end
