defmodule HyperEx.Renderer do
  @moduledoc false

  @void_tags [
    "area",
    "base",
    "br",
    "col",
    "embed",
    "hr",
    "img",
    "input",
    "keygen",
    "link",
    "menuitem",
    "meta",
    "param",
    "source",
    "track",
    "wbr"
  ]

  def render(tag, attrs, _children) when tag in @void_tags do
    open(tag, attrs)
  end

  def render(tag, attrs, children) do
    open(tag, attrs) <> render_children(children) <> close(tag)
  end

  def render_attrs(attrs) do
    attrs
    |> Enum.map(fn {attr, val} -> "#{attr}=\"#{val}\"" end)
    |> Enum.join(" ")
  end

  def render_children(""), do: ""
  def render_children([]), do: ""
  def render_children(children) when is_binary(children), do: children
  def render_children(children) when is_list(children), do: Enum.join(children)

  def open(tag), do: "<#{tag}>"
  def open(tag, []), do: "<#{tag}>"
  def open(tag, attrs), do: "<#{tag} #{render_attrs(attrs)}>"

  def close(tag) when tag in @void_tags, do: ""
  def close(tag), do: "</#{tag}>"
end
