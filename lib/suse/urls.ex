defmodule Suse.Urls do
  alias Suse.Repo
  alias Suse.Urls.Url
  alias Suse.Urls.SlugGenerator

  def change(params \\ %{}) do
    Url.changeset(%Url{}, params)
  end

  def create(params) do
    slug = SlugGenerator.generate()

    params
    |> Map.put_new("slug", slug)
    |> change()
    |> Repo.insert()
  end

  def get(id), do: Repo.get(Url, id)

  def get_by_slug(slug) do
    case Repo.get_by(Url, slug: slug) do
      %Url{} = url ->
        {:ok, url}

      nil ->
        {:error, :url_not_found}
    end
  end
end
