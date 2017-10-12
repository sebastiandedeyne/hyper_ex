defmodule HyperEx.Abbreviation do
  @moduledoc false

  alias HyperEx.Util

  @doc """
  Expands an Emmet-like abbreviation to a tuple containing the tag name and 
  it's attributes (can contain an id and a class list).

  ## Examples

      iex> HyperEx.Abbreviation.expand("div")
      {"div", []}

      iex> HyperEx.Abbreviation.expand("div#foo")
      {"div", [id: "foo"]}

      iex> HyperEx.Abbreviation.expand("div.foo")
      {"div", [class: "foo"]}

      iex> HyperEx.Abbreviation.expand("div.foo.bar")
      {"div", [class: "foo bar"]}

      iex> HyperEx.Abbreviation.expand("div#foo.bar")
      {"div", [id: "foo", class: "bar"]}

      iex> HyperEx.Abbreviation.expand("#foo")
      {"div", [id: "foo"]}

      iex> HyperEx.Abbreviation.expand("#.foo")
      {"div", [class: "foo"]}

  """
  def expand(abbreviation) do
    # "div#foo.bar..baz"
    # ["div", "#", "foo", ".", ".", "bar", ".", "baz"]
    # ["div", "#foo", ".bar", ".", ".baz"]
    # ["div", "#foo", ".bar", ".baz"]
    # {"div", ["#foo", ".bar", ".baz"]}
    # {"div", [id: "foo", class: "bar baz"]}
    abbreviation
    |> explode
    |> regroup_separators
    |> reject_invalid_selectors
    |> extract_tag
    |> selectors_to_attributes
  end

  defp explode(abbreviation) do
    String.split(abbreviation, ~r{#|\.}, include_captures: true, trim: true)
  end

  # When building the selectors from a list, we'll occasionally need access to
  # the last element we processed, which is part of the new selectors list. 
  # It's way easier to pattern match the first element of a list (the head) 
  # than the  last in Elixir, so we're going to build the selectors list 
  # backwards, and reverse it afterwards.
  defp regroup_separators(parts) do
    parts
    |> Enum.reduce([], &build_selector/2)
    |> Enum.reverse()
  end

  defp build_selector("#", selectors), do: ["#"] ++ selectors
  defp build_selector(".", selectors), do: ["."] ++ selectors
  defp build_selector(selector, []), do: [selector]
  defp build_selector(selector, [head | tail]), do: [head <> selector] ++ tail

  defp reject_invalid_selectors(selectors) do
    Enum.reject(selectors, fn s -> s in ["#", "."] end)
  end

  defp extract_tag([]), do: {"div", []}
  defp extract_tag(["#" <> head | tail]), do: {"div", ["##{head}"] ++ tail}
  defp extract_tag(["." <> head | tail]), do: {"div", [".#{head}"] ++ tail}
  defp extract_tag([head | tail]), do: {head, tail}

  defp selectors_to_attributes({tag, selectors}) do
    attributes =
      selectors
      |> Enum.map(&selector_to_attribute/1)
      |> Util.merge_attrs()

    {tag, attributes}
  end

  defp selector_to_attribute("#" <> selector), do: [id: selector]
  defp selector_to_attribute("." <> selector), do: [class: selector]
end
