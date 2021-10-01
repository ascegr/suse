defmodule Suse.Urls do
  @moduledoc """
  Urls Context Module

  This module is responsible for all actions on the Url schema
  that we use in the database to store the shortened urls.
  """
  alias Suse.Repo
  alias Suse.Urls.SlugGenerator
  alias Suse.Urls.Url

  require Logger

  def change(params \\ %{}) do
    Url.changeset(%Url{}, params)
  end

  @doc """
  Try to create the new URL with a random Slug, but in case that URL has
  already been generated and asigned to a URL, we try to recreate with a new
  Slug. This is efficient enough for a while, as we have 62^5 different slugs
  available. If we
  """
  def create(params) do
    slug = SlugGenerator.generate()

    changeset =
      params
      |> Map.put_new("slug", slug)
      |> change()

    case Repo.insert(changeset) do
      {:error, %{errors: [slug: {"has already been taken", _}]}} ->
        Logger.error("Slug already taken", slug: slug)

        params
        |> Map.drop(["slug"])
        |> create()

      ok_or_different_error ->
        ok_or_different_error
    end
  end

  def get(id), do: Repo.get(Url, id)

  def get_by_slug(slug) do
    case Repo.get_by(Url, slug: slug) do
      %Url{} = url ->
        {:ok, url}

      nil ->
        Logger.error("Url not found", slug: slug)

        {:error, :url_not_found}
    end
  end
end
