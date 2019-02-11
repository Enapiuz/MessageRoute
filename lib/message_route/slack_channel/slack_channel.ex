defmodule MessageRoute.SlackChannel do
  alias MessageRoute.Exchange.Command

  @spec send(MessageRoute.Exchange.Command.t()) :: MessageRoute.Exchange.Command.t()
  def send(%Command{user: %{email: email}, body: body} = command) do
    Slack.Web.Users.list()
    |> Map.get("members")
    |> Enum.filter(fn member ->
      Map.get(member, "profile")
      |> Map.get("email") == email
    end)
    |> List.first
    |> Map.get("id")
    |> Slack.Web.Chat.post_message(body)
    {:ok, %{command | success: true}}
  end
end
