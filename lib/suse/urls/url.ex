defmodule Suse.Urls.Url do
  @moduledoc """
  Url schema module
  """

  use Ecto.Schema

  import Ecto.Changeset

  schema "urls" do
    field :long_url, :string
    field :slug, :string

    timestamps()
  end

  @link_format_error_msg "the link has to begin with http:// or https://"

  def changeset(url, attrs) do
    url
    |> cast(attrs, [:long_url, :slug])
    |> validate_required([:long_url, :slug])
    |> validate_format(:long_url, ~r/^(http|https):\/\//, message: @link_format_error_msg)
    |> validate_format(:slug, ~r/([a-zA-Z0-9]{7})/)
  end
end
