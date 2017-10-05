defmodule HyperEx.Util do
  @moduledoc false

  @doc """
  Merge a list of attribute lists.

  ## Examples

      iex> HyperEx.Util.merge_attrs([[id: "a"], [class: "b"], [class: "c", id: "d"]])
      [class: "b c", id: "d"]
  """
  def merge_attrs(attrs) do
    Enum.reduce(attrs, [], fn b, a -> merge_attrs(a, b) end)
  end

  @doc """
  Merge two attribute lists.

  ## Examples

      iex> HyperEx.Util.merge_attrs([id: "a"], [class: "b", id: "c"])
      [class: "b", id: "c"]
  """
  def merge_attrs(a, b) do
    Keyword.merge(a, b, &merge_attr/3) 
  end

  defp merge_attr(:class, c1, c2), do: "#{c1} #{c2}"
  defp merge_attr(_attr, _a, b), do: b
end
