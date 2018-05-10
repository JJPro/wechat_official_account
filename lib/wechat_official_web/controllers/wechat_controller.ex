defmodule WechatOfficialWeb.WechatController do
  use WechatOfficialWeb, :controller

  plug Wechat.Plugs.RequestValidator
  plug Wechat.Plugs.MessageParser when action in [:create]

  def index(conn, %{"echostr" => echostr}) do
    text conn, echostr |> IO.inspect(label: ">>>>> echostr")
  end

  # def create(conn, _params) do
  #   # _params  |> IO.inspect(label: ">>>>> params")
  #   msg = conn.body_params |> IO.inspect(label: ">>>>> msg")
  #
  #   case msg["MsgType"] do
  #     "text" ->
  #       with %{"Content" => content, "FromUserName" => from, "ToUserName" => to} <- msg do
  #         # do something with user content
  #         render conn, "text.xml", reply: %{from: to, to: from, content: content}
  #       end
  #     "image" ->
  #       with %{"PicUrl" => image, "MediaId" => mediaId, "FromUserName" => from, "ToUserName" => to} <- msg do
  #         render conn, "image.xml", reply: %{from: to, to: from, image: image, mediaId: mediaId}
  #         # Wechat.Message.Custom.send_image(from, mediaId)
  #         # conn
  #       end
  #     _ -> conn
  #   end
  # end

  def create(conn, _) do
    msg = conn.body_params
    reply(conn, msg)
  end

  defp reply(conn, %{"Content" => text, "ToUserName" => to, "FromUserName" => from}) do
    render conn, "text.xml", reply: %{from: to, to: from, content: text}
  end

  # defp build_text_reply(%{"ToUserName" => to, "FromUserName" => from, "Content" => content}) do
  #   # FromUserName is user's OpenID to our official account
  #   %{from: to, to: from, content: "Hi thanks for your \n content " <> content}
  # end
  #
  # defp build_text_reply(%{"ToUserName" => to, "FromUserName" => from, "PicUrl" => url}) do
  #   # FromUserName is user's OpenID to our official account
  #   %{from: to, to: from, content: "Hi thanks for your \n content " <> url}
  # end
end
