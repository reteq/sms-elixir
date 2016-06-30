defmodule Sms.SmsProvider do
	use Behaviour

	@doc """
	interface for sms provider which can be set in config.exs
	"""
	defcallback  send(String.t, String.t, Any) ::  {:ok, any} | {:error, any}
end
