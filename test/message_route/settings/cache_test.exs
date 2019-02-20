defmodule MessageRoute.SettingsCacheTest do
  use ExUnit.Case

  alias MessageRoute.Settings.Cache

  @valid_data {1, true, [], "test"}

  test "caches and finds the correct data" do
    assert Cache.set("test", @valid_data) == @valid_data
    assert Cache.get("test") == {:ok, @valid_data}
  end

  test "returns error on non existent key" do
    assert Cache.get("non_existent") == {:error}
  end
end
