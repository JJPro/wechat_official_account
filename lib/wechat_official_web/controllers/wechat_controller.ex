defmodule WechatOfficialWeb.WechatController do
  use WechatOfficialWeb, :controller

  plug Wechat.Plugs.RequestValidator
  plug Wechat.Plugs.MessageParser when action in [:create]

  def index(conn, %{"echostr" => echostr}) do
    text conn, echostr |> IO.inspect(label: ">>>>> echostr")
  end

  def create(conn, _params) do
    # _params  |> IO.inspect(label: ">>>>> params")
    msg = conn.body_params |> IO.inspect(label: ">>>>> conn.body_params")
    reply = build_text_reply(msg)
    Wechat.Message.Custom.send_text(msg["FromUserName"], "hi there")
    render conn, "text.xml", reply: reply
  end

  defp build_text_reply(%{"ToUserName" => to, "FromUserName" => from, "Content" => content}) do
    # FromUserName is user's OpenID to our official account
    %{from: to, to: from, content: "Hi thanks for your \n content " <> content}
  end
end
