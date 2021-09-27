defmodule SuseWeb.Api.UrlControllerTest do
  use SuseWeb.ConnCase

  describe "POST /urls" do
    test "with empty long_url shows an error", %{conn: conn} do
      conn = post(conn, "/api/urls", %{long_url: ""})
      assert %{"error" => "URL can't be empty", "status" => "error"} == json_response(conn, 400)
    end

    test "with wrong long_url shows an error", %{conn: conn} do
      conn = post(conn, "/api/urls", %{long_url: "asdf"})

      assert %{"error" => "the link has to begin with http:// or https://", "status" => "error"} ==
               json_response(conn, 400)
    end

    test "with proper long_url, returns a short url", %{conn: conn} do
      long_url = "https://www.google.com/whatever/whatever"
      conn = post(conn, "/api/urls", %{long_url: long_url})

      [%{slug: slug}] = Suse.Repo.all(Suse.Urls.Url)

      short_url = "http://localhost:4000/#{slug}"

      assert %{"status" => "created", "url" => ^short_url} = json_response(conn, 200)
    end
  end
end
