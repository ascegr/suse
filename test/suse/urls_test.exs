defmodule Suse.UrlsTest do
  use Suse.DataCase

  alias Ecto.Changeset
  alias Suse.Repo
  alias Suse.SlugGenerator
  alias Suse.Urls
  alias Suse.Urls.Url

  describe "create/1" do
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
end
