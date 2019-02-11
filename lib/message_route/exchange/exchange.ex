defmodule MessageRoute.Exchange do
  @moduledoc """
  The Exchange context.

  Gets raw messages from the Messages context and
  prepares them for send into concrete chanel.
  """

  require Logger

  alias MessageRoute.Accounts
  alias MessageRoute.Messages
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
      {:ok, command} <- validate_user_subscription(command),
      {:ok, command} <- prepare_body(command, body),
      {:ok, command} <- send(command)
    ) do
      log_changes(:ok, command, message)
    else
      {status, command} ->
        log_changes(status, command, message)
    end
  end

  defp get_user(%Command{} = command, email) do
    user = Accounts.get_or_create_user_by_email(email)
    {:ok, %{command | user: user}}
  end

  defp get_channel(%Command{} = command, _topic) do
    {:ok, %{command | channel: :slack}}
  end

  defp validate_user_subscription(%Command{} = command) do
    {:ok, command}
  end

  defp prepare_body(%Command{} = command, body) do
    {:ok, %{command | body: body}}
  end

  defp send(%Command{channel: channel} = command) do
    case channel do
      :slack -> SlackChannel.send(command)
      _ -> {:error, command}
    end
  end

  defp log_changes(status, %Command{} = command, %RawMessage{} = message) do
    case status do
      :ok ->
        Messages.mark_raw_message_sent(message)
        Logger.info "Message id##{message.id} sent"
        {:ok, command}

      _ ->
        Logger.info "Error sending message id##{message.id}"
        {:error, command}
    end
  end
end
