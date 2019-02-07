defmodule MessageRoute.ReceiverTest do
  use MessageRoute.DataCase

  alias MessageRoute.Receiver

  describe "raw_messages" do
    alias MessageRoute.Receiver.RawMessage

    @valid_attrs %{body: "some body", to: "some to", topic: "some topic"}
    @update_attrs %{body: "some updated body", to: "some updated to", topic: "some updated topic"}
    @invalid_attrs %{body: nil, to: nil, topic: nil}

    def raw_message_fixture(attrs \\ %{}) do
      {:ok, raw_message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Receiver.create_raw_message()

      raw_message
    end

    test "list_raw_messages/0 returns all raw_messages" do
      raw_message = raw_message_fixture()
      assert Receiver.list_raw_messages() == [raw_message]
    end

    test "get_raw_message!/1 returns the raw_message with given id" do
      raw_message = raw_message_fixture()
      assert Receiver.get_raw_message!(raw_message.id) == raw_message
    end

    test "create_raw_message/1 with valid data creates a raw_message" do
      assert {:ok, %RawMessage{} = raw_message} = Receiver.create_raw_message(@valid_attrs)
      assert raw_message.body == "some body"
      assert raw_message.to == "some to"
      assert raw_message.topic == "some topic"
    end

    test "create_raw_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Receiver.create_raw_message(@invalid_attrs)
    end

    test "update_raw_message/2 with valid data updates the raw_message" do
      raw_message = raw_message_fixture()
      assert {:ok, %RawMessage{} = raw_message} = Receiver.update_raw_message(raw_message, @update_attrs)
      assert raw_message.body == "some updated body"
      assert raw_message.to == "some updated to"
      assert raw_message.topic == "some updated topic"
    end

    test "update_raw_message/2 with invalid data returns error changeset" do
      raw_message = raw_message_fixture()
      assert {:error, %Ecto.Changeset{}} = Receiver.update_raw_message(raw_message, @invalid_attrs)
      assert raw_message == Receiver.get_raw_message!(raw_message.id)
    end

    test "delete_raw_message/1 deletes the raw_message" do
      raw_message = raw_message_fixture()
      assert {:ok, %RawMessage{}} = Receiver.delete_raw_message(raw_message)
      assert_raise Ecto.NoResultsError, fn -> Receiver.get_raw_message!(raw_message.id) end
    end

    test "change_raw_message/1 returns a raw_message changeset" do
      raw_message = raw_message_fixture()
      assert %Ecto.Changeset{} = Receiver.change_raw_message(raw_message)
    end
  end
end
