defmodule Suse.Urls.Url do
  use Ecto.Schema

  import Ecto.Changeset

  alias Suse.SlugGenerator

  schema "urls" do
    field :long_url, :string
    field :slug, :string

    timestamps()
  end

  @link_format_error_msg "the link has to begin with http:// or https://"

  def changeset(url, attrs) do
    url
    |> cast(attrs, [:long_url])
    |> validate_format(:long_url, ~r/^(http|https):\/\//, message: @link_format_error_msg)
    |> put_slug()
  end

  defp put_slug(changeset) do
    put_change(changeset, :slug, SlugGenerator.generate())
  end
end
