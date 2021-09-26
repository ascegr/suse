defmodule Suse.UrlsTest do
  use Suse.DataCase

  alias Ecto.Changeset
  alias Suse.Repo
  alias Suse.Urls
  alias Suse.Urls.SlugGenerator
  alias Suse.Urls.Url

  describe "create/1" do
    test "with an empty url, returns an error" do
      message = "can't be blank"

      assert {:error, %Changeset{errors: errors}} = Urls.create(%{"long_url" => ""})
      assert [{:long_url, {^message, [validation: :required]}}] = errors
    end

    test "with an https url, inserts a new url with a slug" do
      long_url = "https://suse.stord.com/long/url/path"

      assert {:ok, %Url{slug: slug, long_url: ^long_url}} = Urls.create(%{"long_url" => long_url})
      assert String.length(slug) == 7
    end

    test "with an http url, inserts a new url with a slug" do
      long_url = "http://suse.stord.com/long/url/path"

      assert {:ok, %Url{slug: slug, long_url: ^long_url}} = Urls.create(%{"long_url" => long_url})
      assert String.length(slug) == 7
    end

    test "with a non proper url, returns an error" do
      long_url = "suse.stord.com/long/url/path"
      message = "the link has to begin with http:// or https://"

      assert {:error, %Changeset{errors: errors}} = Urls.create(%{"long_url" => long_url})
      assert [{:long_url, {^message, [validation: :format]}}] = errors
    end
  end

  describe "get_by_slug/1" do
    test "returns {:error, :url_not_found} if the slug does not exist" do
      assert {:error, :url_not_found} == Urls.get_by_slug(SlugGenerator.generate())
    end

    test "returns {:ok, %Url{}} given the slug" do
      long_url = "https://suse.stord.com/long/url/path"
      slug = SlugGenerator.generate()
      url = %Url{long_url: long_url, slug: slug}

      Repo.insert!(url)

      assert {:ok, %Url{slug: ^slug, long_url: ^long_url}} = Urls.get_by_slug(url.slug)
    end
  end

  describe "change/1" do
    test "without any params, returns an Ecto.Changeset for the form" do
      assert %Ecto.Changeset{changes: %{}} = Urls.change()
    end
  end

  describe "get/1" do
    test "with a non existing id, returns nil" do
      assert nil == Urls.get(500)
    end

    test "with an existing id, returns the Url" do
      slug = SlugGenerator.generate()
      long_url = "https://suse.stord.com/long/url/path"
      url = %Url{long_url: long_url, slug: slug}
      %{id: id} = Repo.insert!(url)

      assert %Url{slug: ^slug, long_url: ^long_url} = Urls.get(id)
    end
  end
end
