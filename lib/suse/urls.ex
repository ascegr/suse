defmodule Suse.Urls do
  alias Suse.Repo
  alias Suse.Urls.Url

  def create(params) do
    %Url{}
    |> Url.changeset(params)
    |> Repo.insert()
  end

  def get_by_slug(slug) do
    case Repo.get_by(Url, slug: slug) do
      %Url{} = url ->
        {:ok, url}

      nil ->
        {:error, :url_not_found}
    end
  end
end
