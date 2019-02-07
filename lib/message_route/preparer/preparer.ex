defmodule MessageRoute.Preparer do
  @moduledoc """
  The Preparer context.
  Gets raw messages from the Receiver context and
  prepares them for send into concrete chanel.
  """

  alias MessageRoute.Receiver.RawMessage

  @doc """
  Gets message, prepares it for concrete channel,
  then sends it to concrete channel send queue.
  """
  def prepare(%RawMessage{} = _) do
    IO.puts "preparing..."
  end
end
