defmodule MessageRoute.MessagesTest do
  use MessageRoute.DataCase

  alias MessageRoute.Messages

  describe "raw_messages" do
    alias MessageRoute.Messages.RawMessage

    @valid_attrs %{body: "some body", to: "some to", topic: "some topic", done: false}
    @update_attrs %{body: "some updated body", to: "some updated to", topic: "some updated topic", done: true}
    @invalid_attrs %{body: nil, to: nil, topic: nil, done: nil}

    def raw_message_fixture(attrs \\ %{}) do
      {:ok, raw_message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_raw_message()

      raw_message
    end

    test "list_raw_messages/0 returns all raw_messages" do
      raw_message = raw_message_fixture()
      assert Messages.list_raw_messages() == [raw_message]
    end

    test "get_raw_message!/1 returns the raw_message with given id" do
      raw_message = raw_message_fixture()
      assert Messages.get_raw_message!(raw_message.id) == raw_message
    end

    test "create_raw_message/1 with valid data creates a raw_message" do
      assert {:ok, %RawMessage{} = raw_message} = Messages.create_raw_message(@valid_attrs)
      assert raw_message.body == "some body"
      assert raw_message.to == "some to"
      assert raw_message.topic == "some topic"
      assert raw_message.done == false
    end

    test "create_raw_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_raw_message(@invalid_attrs)
    end

    test "update_raw_message/2 with valid data updates the raw_message" do
      raw_message = raw_message_fixture()
      assert {:ok, %RawMessage{} = raw_message} = Messages.update_raw_message(raw_message, @update_attrs)
      assert raw_message.body == "some updated body"
      assert raw_message.to == "some updated to"
      assert raw_message.topic == "some updated topic"
      assert raw_message.done == true
    end

    test "update_raw_message/2 with invalid data returns error changeset" do
      raw_message = raw_message_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_raw_message(raw_message, @invalid_attrs)
      assert raw_message == Messages.get_raw_message!(raw_message.id)
    end

    test "delete_raw_message/1 deletes the raw_message" do
      raw_message = raw_message_fixture()
      assert {:ok, %RawMessage{}} = Messages.delete_raw_message(raw_message)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_raw_message!(raw_message.id) end
    end

    test "change_raw_message/1 returns a raw_message changeset" do
      raw_message = raw_message_fixture()
      assert %Ecto.Changeset{} = Messages.change_raw_message(raw_message)
    end
  end
end
