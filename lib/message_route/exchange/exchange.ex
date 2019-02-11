defmodule MessageRoute.Exchange do
  @moduledoc """
  The Exchange context.

  Gets raw messages from the Receiver context and
  prepares them for send into concrete chanel.
  """

  alias MessageRoute.Accounts
  alias MessageRoute.Receiver
  alias MessageRoute.Receiver.RawMessage
  alias MessageRoute.Exchange.Command
  alias MessageRoute.SlackChannel

  @doc """
  Gets message, prepares it for concrete channel,
  then sends it to concrete channel send queue.
  """
  def push(%RawMessage{to: email, topic: topic, body: body} = message) do
    %Command{success: false}
    |> get_user(email)
    |> get_channel(topic)
    |> validate_user_subscription()
    |> prepare_body(body)
    |> send()
    |> log_changes(message)
  end

  defp get_user(%Command{} = command, email) do
    user = Accounts.get_or_create_user_by_email(email)
    {:ok, %{command | user: user}}
  end

  defp get_channel({:ok, %Command{} = command}, _topic) do
    {:ok, %{command | channel: :slack}}
  end

  defp validate_user_subscription({:ok, %Command{} = command}) do
    {:ok, command}
  end

  defp prepare_body({:ok, %Command{} = command}, body) do
    {:ok, %{command | body: body}}
  end

  defp send({:ok, %Command{channel: channel} = command}) do
    case channel do
      :slack -> SlackChannel.send(command)
    end
  end

  defp log_changes({_status, %Command{success: success} = command}, %RawMessage{} = message) do
    IO.inspect command
    case success do
      true ->
        IO.puts("Message successfully sent!")
        Receiver.mark_raw_message_sent(message)
      _ -> IO.puts("Error sending message")
    end
  end
end
