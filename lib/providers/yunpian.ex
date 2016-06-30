defmodule Sms.Yunpian do
  @behaviour Sms.SmsProvider
  use HTTPoison.Base

  @get_url "/get.json"
  @send_url "/send.json"
  @tpl_send_url "/tpl_send.json"

  def process_url(url) do
    "http://sms.yunpian.com/v1/sms" <> url
  end

  @doc """
  error response example: 
    "{\"code\":1,\"msg\":\"请求参数缺失\",\"detail\":\"参数 apikey 必须传入\"}"
    "{\"code\":5,\"msg\":\"未找到匹配的模板\",\"detail\":\"未自动匹配到合适的模板\"}"
  """
  def send(phone, content, options \\ []) do
    password = Application.get_env(:sms, :apikey)
    if password do
      req_headers = %{"Accept" => "application/json; charset=utf-8;",
      "Content-type" => "application/x-www-form-urlencoded;charset=utf-8;"}

      body = {:form, [mobile: phone, 
      text: content,
      apikey: password] ++ options}

      response = post(@send_url, body, req_headers)

      case(response) do
        {:ok, %HTTPoison.Response{status_code: _code,
          headers: _headers,
          body: resp_body}} ->
            try do
              json = Poison.decode!(resp_body)
              case(json) do
                %{"code" => 0, "msg" => _msg, "result" => result} -> {:ok, result}
                %{"code" => _code, "msg" => _msg} -> {:error, json}
              end
            rescue
              _e -> {:error, resp_body}
            end
        {:error, reason} -> {:error, reason}
      end
    else
      {:error, "no apikey set in config"}
    end
  end
end
