defmodule MessageRoute.TopicsTest do
  use MessageRoute.DataCase

  alias MessageRoute.Topics

  describe "topics" do
    alias MessageRoute.Topics.Topic

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Topics.create_topic()

      topic
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Topics.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Topics.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Topics.create_topic(@valid_attrs)
      assert topic.name == "some name"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Topics.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{} = topic} = Topics.update_topic(topic, @update_attrs)
      assert topic.name == "some updated name"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Topics.update_topic(topic, @invalid_attrs)
      assert topic == Topics.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Topics.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Topics.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Topics.change_topic(topic)
    end
  end

  describe "user_topics" do
    alias MessageRoute.Topics.UserTopic

    @valid_attrs %{subscribed: true}
    @update_attrs %{subscribed: false}
    @invalid_attrs %{subscribed: nil}

    def user_topic_fixture(attrs \\ %{}) do
      {:ok, user_topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Topics.create_user_topic()

      user_topic
    end

    test "list_user_topics/0 returns all user_topics" do
      user_topic = user_topic_fixture()
      assert Topics.list_user_topics() == [user_topic]
    end

    test "get_user_topic!/1 returns the user_topic with given id" do
      user_topic = user_topic_fixture()
      assert Topics.get_user_topic!(user_topic.id) == user_topic
    end

    test "create_user_topic/1 with valid data creates a user_topic" do
      assert {:ok, %UserTopic{} = user_topic} = Topics.create_user_topic(@valid_attrs)
      assert user_topic.subscribed == true
    end

    test "create_user_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Topics.create_user_topic(@invalid_attrs)
    end

    test "update_user_topic/2 with valid data updates the user_topic" do
      user_topic = user_topic_fixture()
      assert {:ok, %UserTopic{} = user_topic} = Topics.update_user_topic(user_topic, @update_attrs)
      assert user_topic.subscribed == false
    end

    test "update_user_topic/2 with invalid data returns error changeset" do
      user_topic = user_topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Topics.update_user_topic(user_topic, @invalid_attrs)
      assert user_topic == Topics.get_user_topic!(user_topic.id)
    end

    test "delete_user_topic/1 deletes the user_topic" do
      user_topic = user_topic_fixture()
      assert {:ok, %UserTopic{}} = Topics.delete_user_topic(user_topic)
      assert_raise Ecto.NoResultsError, fn -> Topics.get_user_topic!(user_topic.id) end
    end

    test "change_user_topic/1 returns a user_topic changeset" do
      user_topic = user_topic_fixture()
      assert %Ecto.Changeset{} = Topics.change_user_topic(user_topic)
    end
  end
end
