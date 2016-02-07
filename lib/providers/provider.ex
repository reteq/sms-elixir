defmodule Sms.SmsProvider do
	use Behaviour

	@doc """
	interface for sms provider which can be set in config.exs
	"""
	defcallback  send(String.t, String.t) ::  {:ok} | {:error, String.t}
end