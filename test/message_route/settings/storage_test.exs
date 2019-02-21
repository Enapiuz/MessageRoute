defmodule MessageRoute.SettingsStorageTest do
  use ExUnit.Case

  alias MessageRoute.Settings.Storage

  @valid_data {1, true, [], "test"}

  test "caches and finds the correct data" do
    assert Storage.set("test", @valid_data) == @valid_data
    assert Storage.get("test") == {:ok, @valid_data}
  end

  test "returns error on non existent key" do
    assert Storage.get("non_existent") == {:error}
  end
end
