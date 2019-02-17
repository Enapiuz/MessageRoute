defmodule MessageRoute.SlackChannel do
  require Logger
  alias MessageRoute.Exchange.Command

  @spec send(MessageRoute.Exchange.Command.t()) :: MessageRoute.Exchange.Command.t()
  def send(%Command{user: user} = command) do
    with(
      %{"members" => members} <- get_slack_user_list(),
      %{email: email} <- user,
      target_user <- get_target_member(members, email),
      command <- send_by_id(target_user, command)
    ) do
      command
    else
      %{"error" => error} ->
        Logger.error("Error calling slack api", error)
        {:error, command}

      :error ->
        Logger.error("Invalid data in :members or :email")
        {:error, command}

      error ->
        Logger.error("Unknown error #{inspect(error)}")
        {:error, command}
    end
  end

  defp get_slack_user_list do
    Slack.Web.Users.list()
  end

  defp get_target_member(members, email) do
    members
    |> Enum.filter(fn member ->
      with(
        {:ok, profile} <- Map.fetch(member, "profile"),
        {:ok, member_email} <- Map.fetch(profile, "email")
      ) do
        member_email == email
      else
        _ ->
          false
      end
    end)
    |> List.first()
  end

  defp send_by_id(member, %{body: body} = command) do
    case member do
      %{"id" => id} ->
        Slack.Web.Chat.post_message(id, body)
        {:ok, command}

      error ->
        Logger.error("Error calling slack post_message: #{inspect(error)}")
        {:error, command}
    end
  end
end
