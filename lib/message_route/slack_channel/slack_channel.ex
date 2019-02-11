defmodule MessageRoute.SlackChannel do
  alias MessageRoute.Exchange.Command

  @spec send(MessageRoute.Exchange.Command.t()) :: MessageRoute.Exchange.Command.t()
  def send(%Command{user: user} = command) do
    with(
      slack_users <- Slack.Web.Users.list(),
      {:ok, members} <- Map.fetch(slack_users, :members),
      {:ok, email} <- Map.fetch(user, :email),
      target_user <- get_target_member(members, email),
      command <- send_by_id(target_user, command)
    ) do
      command
    else
      %{"error" => _error} ->
        {:error, command}
      _ ->
        {:error, command}
    end
  end

  defp get_target_member(members, email) do
    members
    |> Enum.filter(fn member ->
      Map.get(member, :profile)
      |> Map.get("email") == email
    end)
    |> List.first()
  end

  defp send_by_id(member, %{body: body} = command) do
    case member do
      %{"id" => id} ->
        Slack.Web.Chat.post_message(id, body)
        {:ok, command}

      _ ->
        {:error, command}
    end
  end
end
