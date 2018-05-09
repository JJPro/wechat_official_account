defmodule WechatOfficialWeb.WechatController do
  use WechatOfficialWeb, :controller

  plug Wechat.Plugs.RequestValidator
  plug Wechat.Plugs.MessageParser when action in [:create]

  def index(conn, %{"echostr" => echostr}) do
    text conn, echostr
  end

  def create(conn, _params |> IO.inspect(label: ">>>>> params")) do
    msg = conn.body_params |> IO.inspect(label: ">>>>> conn.body_params")
    reply = build_text_reply(msg, msg.content)
    render conn, "text.xml", reply: reply
  end

  defp build_text_reply(%{"ToUserName" => to, "FromUserName" => from}, content) do
    %{from: to, to: from, content: content}
  end
end
