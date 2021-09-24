defmodule Suse.SlugGenerator do
  @moduledoc """
  This module is responsible for generating a random string
  that consists of small letters, large letters and numbers.

  The string calculating code can be turned into module attributes to
  reduce strain, as could be pre-calculated and compiled only once.
  """

  @number_range 1..7

  def generate do
    @number_range
    |> pick_characters()
    |> Enum.join()
  end

  defp lower_letters, do: Enum.map(?a..?z, fn x -> <<x::utf8>> end)

  defp upper_letters, do: Enum.map(?A..?Z, fn x -> <<x::utf8>> end)

  defp numbers, do: Enum.map(0..9, fn x -> "#{x}" end)

  defp all_characters, do: List.flatten([lower_letters(), upper_letters(), numbers()])

  defp pick_characters(numbers), do: for(_ <- numbers, do: pick_character())

  def pick_character, do: Enum.random(all_characters())
end
