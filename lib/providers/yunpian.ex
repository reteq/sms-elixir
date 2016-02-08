defmodule Sms.Yunpian do
	@behaviour Sms.SmsProvider
	use HTTPoison.Base

	@get_url "/get.json"	
	@send_url "/send.json"	
	@tpl_send_url "/tpl_send.json"

	def process_url(url) do
		"http://yunpian.com/v1/sms" <> url
	end

	def process_request_body(body) do
		Poison.encode!(body)
	end

	def send(phone, content) do
		username = Application.get_env(:sms, :username)
		password = Application.get_env(:sms, :password)

		if username && password do
			options = %{
				username: username, 
				password: password,
				apikey: password}

			body = %{
				mobile: phone,
				tpl_value: content}

			{:ok, %HTTPoison.Response{status_code: code,
				headers: _headers,
                body: resp_body}} = post(@send_url, body, options)

        	{code == 200 && :ok || :error, resp_body}
    	else
    		{:error, "no username or password set in config"}
		end
	end
end