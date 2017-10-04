defmodule HyperExTest do
  use ExUnit.Case
  doctest HyperEx

  test "greets the world" do
    assert HyperEx.hello() == :world
  end
end
