defmodule SuseWeb.UrlControllerTest do
  use SuseWeb.ConnCase

  alias Suse.Repo
  alias Suse.Urls.SlugGenerator
  alias Suse.Urls.Url

  describe "GET /" do
    test "has welcome text", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "Welcome to Super URL Shortener Exercise"
    end

    test "has a url form with only the long url field", %{conn: conn} do
      conn = get(conn, "/")
      assert html = html_response(conn, 200)
      assert html =~ "id=\"form-long-url\""
      assert html =~ "id=\"long_url\""
    end
  end

  describe "POST /urls" do
    test "with empty long_url shows an error", %{conn: conn} do
      conn = post(conn, "/urls", %{long_url: ""})
      assert html_response(conn, 200) =~ "Please enter a valid URL"
    end

    test "with invalid long_url shows an error", %{conn: conn} do
      conn = post(conn, "/urls", %{long_url: "invalid_url"})
      assert html_response(conn, 200) =~ "Please enter a valid URL"
    end

    test "with valid long_url shows the slugified link", %{conn: conn} do
      # Overwriting the slug here to control the output
      slug = SlugGenerator.generate()
      conn = post(conn, "/urls", %{long_url: "http://facebook.com", slug: slug})

      [url] = Repo.all(Url)

      assert redirected_to(conn) =~ Routes.url_path(conn, :show, url)
    end
  end

  describe "GET /urls/:id" do
    test "with a non valid id, redirects to root page", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :show, 100))
      assert redirected_to(conn) =~ Routes.url_path(conn, :index)
    end

    test "with a valid id, shows the url and has a copy button", %{conn: conn} do
      slug = SlugGenerator.generate()
      long_url = "https://suse.stord.com/long/url/path"
      url = %Url{long_url: long_url, slug: slug}
      %{id: id} = Repo.insert!(url)

      conn = get(conn, Routes.url_path(conn, :show, id))
      assert html_response(conn, 200) =~ "http://localhost:4000/#{slug}"
      assert html_response(conn, 200) =~ "id=\"copy-url-button\""
    end
  end

  describe "GET /:slug" do
    test "with a non valid slug, redirects to root page", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :redirect_by_slug, "abc0123"))
      assert redirected_to(conn) == Routes.url_path(conn, :index)
    end

    test "with a valid slug, shows a redirection page", %{conn: conn} do
      slug = SlugGenerator.generate()
      long_url = "https://suse.stord.com/long/url/path"
      url = %Url{long_url: long_url, slug: slug}
      Repo.insert!(url)

      conn = get(conn, Routes.url_path(conn, :redirect_by_slug, slug))
      assert redirected_to(conn) =~ long_url
    end
  end

  describe "GET /react" do
    test "mounts the react app", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :react))
      assert html_response(conn, 200) =~ "<x-application"
    end
  end
end
