defmodule MessageRoute.SlackChannel do
  alias MessageRoute.Exchange.Command

  @spec send(MessageRoute.Exchange.Command.t()) :: MessageRoute.Exchange.Command.t()
  def send(%Command{} = command) do
    %{command | success: true}
  end
end
