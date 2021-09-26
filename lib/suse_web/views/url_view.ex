defmodule SuseWeb.UrlView do
  use SuseWeb, :view

  def url_with_domain(%{slug: slug}) do
    "#{get_current_domain()}/#{slug}"
  end

  defp get_current_domain do
    url_settings =
      :suse
      |> Application.get_env(SuseWeb.Endpoint)
      |> Keyword.get(:url, [])

    host = Keyword.get(url_settings, :host, "localhost")
    port = Keyword.get(url_settings, :port, "4000")
    scheme = Keyword.get(url_settings, :scheme, "http")

    "#{scheme}://#{host}#{port(port)}"
  end

  defp port(80), do: nil
  defp port(port), do: ":#{port}"
end
