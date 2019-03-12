defmodule MessageRoute.Exchange do
  @moduledoc """
  The Exchange context.

  Gets raw messages from the Messages context and
  prepares them for send into concrete channel.
  """

  require Logger

  alias MessageRoute.Accounts
  alias MessageRoute.Messages
  alias MessageRoute.Topics
  alias MessageRoute.Messages.RawMessage
  alias MessageRoute.Exchange.Command
  alias MessageRoute.SlackChannel

  @doc """
  Gets message, prepares it for concrete channel,
  then sends it to concrete channel send queue.
  """
  def push(%RawMessage{to: email, topic: topic, body: body} = message) do
    with(
      {:ok, command} <- get_user(%Command{}, email),
      {:ok, command} <- get_channel(command, topic),
      {:ok, command} <- validate_user_subscription(command, topic),
      {:ok, command} <- prepare_body(command, body),
      {:ok, command} <- send_command(command)
    ) do
      log_changes(:ok, command, message)
    else
      {:error, :not_subscribed, command} ->
        log_changes(:ok, command, message)

      {status, command} ->
        log_changes(status, command, message)
    end
  end

  defp get_user(%Command{} = command, email) do
    user = Accounts.get_or_create_user_by_email(email)
    {:ok, %{command | user: user}}
  end

  defp get_channel(%Command{user: %{topics: topics} = user} = command, topic) do
    subscribed_channel = get_topic_subscription(topics, topic)
    Logger.debug("Subscribed channel name: #{inspect(subscribed_channel)}")

    if length(topics) > 0 and subscribed_channel != nil do
      Logger.debug("Using existing user_topics")

      case subscribed_channel do
        "slack" ->
          {:ok, %{command | channel: :slack}}

        _ ->
          Logger.error("Unknown channel name: #{inspect(subscribed_channel)}")
          {:error, command}
      end
    else
      Logger.debug("Creating new user_topic")
      new_topic = Topics.get_or_create_topic_by_name(topic)

      %{
        subscribed: true,
        channel: "slack"
      }
      |> Topics.create_user_topic(user, new_topic)

      {:ok, %{command | channel: :slack}}
    end
  end

  defp get_topic_subscription(topics, topic_name) do
    topic =
      topics
      |> Enum.filter(fn topic ->
        topic.topic.name == topic_name
      end)
      |> List.first()

    if topic != nil do
      topic.channel
    else
      nil
    end
  end

  defp validate_user_subscription(%Command{user: %{topics: topics} = _user} = command, topic_name) do
    subscription =
      topics
      |> Enum.filter(fn topic ->
        topic.topic.name == topic_name and topic.subscribed
      end)
      |> List.first()

    case subscription do
      nil ->
        {:error, :not_subscribed, command}

      _ ->
        {:ok, command}
    end
  end

  defp prepare_body(%Command{} = command, body) do
    url = MessageRouteWeb.Endpoint.url()
    newBody = body <> "\n <#{url}/user?email=#{command.user.email}|Subscription config>"
    {:ok, %{command | body: newBody}}
  end

  defp send_command(%Command{channel: channel} = command) do
    case channel do
      :slack -> SlackChannel.send(command)
      _ -> {:error, command}
    end
  end

  defp log_changes(status, %Command{} = command, %RawMessage{} = message) do
    case status do
      :ok ->
        Messages.mark_raw_message_sent(message)
        Logger.info("Message id##{message.id} sent")
        {:ok, command}

      _ ->
        Logger.info("Error sending message id##{message.id}")
        {:error, command}
    end
  end
end
