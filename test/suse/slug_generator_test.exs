defmodule Suse.Urls.SlugGeneratorTest do
  use Suse.DataCase

  alias Suse.Urls.SlugGenerator

  describe "generate/0" do
    test "returns a random string" do
      short_url = SlugGenerator.generate()
      assert String.length(short_url) == 7
    end

    test "returns a different string each time" do
      short_url = SlugGenerator.generate()
      another_short_url = SlugGenerator.generate()
      refute short_url == another_short_url
    end

    test "characters are constructed from letters (lower and upper case) and numbers" do
      short_url = SlugGenerator.generate()
      assert Regex.match?(~r/[a-zA-Z0-9]{7}/, short_url)

      short_url = SlugGenerator.generate()
      refute Regex.match?(~r/^[A-Za-z0-9]{7}$/, "asdf#{short_url}asdf")
    end
  end
end
