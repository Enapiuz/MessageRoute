defmodule MessageRoute.SettingsTest do
  use MessageRoute.DataCase

  alias MessageRoute.Settings

  describe "settings" do
    alias MessageRoute.Settings.Entry

    @valid_attrs %{name: "test", value: "some value"}
    @update_attrs %{name: "updated_test", value: "some updated value"}
    @invalid_attrs %{name: nil, value: nil}

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_entry()

      entry
    end

    test "list_settings/0 returns all settings" do
      entry = entry_fixture()
      assert Settings.list_settings() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Settings.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Settings.create_entry(@valid_attrs)
      assert entry.value == "some value"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{} = entry} = Settings.update_entry(entry, @update_attrs)
      assert entry.value == "some updated value"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_entry(entry, @invalid_attrs)
      assert entry == Settings.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Settings.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Settings.change_entry(entry)
    end
  end
end
