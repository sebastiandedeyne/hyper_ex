defmodule HyperEx do
  @moduledoc """
  Documentation for HyperEx.
  """

  alias HyperEx.Abbreviation
  alias HyperEx.Renderer
  alias HyperEx.Util

  @doc """
  The main HyperEx function to render html.

  ## Examples

      iex> HyperEx.h("div")
      ~s{<div></div>}

      iex> HyperEx.h("img")
      ~s{<img>}

      iex> HyperEx.h("div#foo.bar")
      ~s{<div id="foo" class="bar"></div>}

      iex> HyperEx.h("div", "Hello world!")
      ~s{<div>Hello world!</div>}

      iex> HyperEx.h("div", ["Hello ", "world!"])
      ~s{<div>Hello world!</div>}

      iex> HyperEx.h("div", [class: "foo"])
      ~s{<div class="foo"></div>}

      iex> HyperEx.h("div.foo", [class: "bar"], "Hello world!")
      ~s{<div class="foo bar">Hello world!</div>}
  """
  def h(abbreviation) do
    {tag, attrs} = Abbreviation.expand(abbreviation)

    Renderer.render(tag, attrs, "")
  end

  def h(abbreviation, attrs_or_children) do
    {tag, abbreviation_attrs} = Abbreviation.expand(abbreviation)

    case Keyword.keyword?(attrs_or_children) do
      true -> Renderer.render(tag, Util.merge_attrs(abbreviation_attrs, attrs_or_children), "")
      false -> Renderer.render(tag, abbreviation_attrs, attrs_or_children)
    end
  end

  def h(abbreviation, attrs, children) do
    {tag, abbreviation_attrs} = Abbreviation.expand(abbreviation)

    Renderer.render(tag, Util.merge_attrs(abbreviation_attrs, attrs), children)
  end

  @doc """
  Render an opening tag, optionally with attributes.

  ## Examples

      iex> HyperEx.open("div")
      ~s{<div>}

      iex> HyperEx.open("div#foo")
      ~s{<div id="foo">}

      iex> HyperEx.open("div#foo", [class: "bar"])
      ~s{<div id="foo" class="bar">}
  """
  def open(abbreviation) do
    {tag, abbreviation_attrs} = Abbreviation.expand(abbreviation)

    Renderer.open(tag, abbreviation_attrs)
  end

  def open(abbreviation, attrs) do
    {tag, abbreviation_attrs} = Abbreviation.expand(abbreviation)

    Renderer.open(tag, Util.merge_attrs(abbreviation_attrs, attrs))
  end

  @doc """
  Render an closing tag.

  ## Examples

      iex> HyperEx.close("div")
      ~s{</div>}

      iex> HyperEx.close("div#foo")
      ~s{</div>}
  """
  def close(abbreviation) do
    {tag, _abbreviation_attrs} = Abbreviation.expand(abbreviation)

    Renderer.close(tag)
  end

  @doc """
  Wrap a string in html. Behaves like `render` but expects children to be the 
  first argument. Useful for piping.

  ## Examples

      iex> HyperEx.h("div#foo") |> HyperEx.wrap("div#bar")
      ~s{<div id="bar"><div id="foo"></div></div>}

      iex> HyperEx.h("div#foo") |> HyperEx.wrap("div#bar", [class: "baz"])
      ~s{<div id="bar" class="baz"><div id="foo"></div></div>}
  """
  def wrap(contents, abbreviation), do: h(abbreviation, contents)
  def wrap(contents, abbreviation, attrs), do: h(abbreviation, attrs, contents)
end
