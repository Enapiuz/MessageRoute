defmodule MessageRoute.Preparer do
  @moduledoc """
  The Preparer context.
  Gets raw messages from the Receiver context and
  prepares them for send into concrete chanel.
  """

  alias MessageRoute.Accounts
  alias MessageRoute.Receiver.RawMessage

  @doc """
  Gets message, prepares it for concrete channel,
  then sends it to concrete channel send queue.
  """
  def prepare(%RawMessage{to: email}) do
    IO.puts "preparing..."
    Accounts.get_or_create_user_by_email(email)
    |> get_channel
    |> prepare_body
    |> send
  end

  def get_channel(_), do: nil
  def prepare_body(_), do: nil
  def send(_), do: IO.puts "sent"
end
