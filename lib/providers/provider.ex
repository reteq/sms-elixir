defmodule Sms.SmsProvider do
	use Behaviour

	@doc """
	"""
	defcallback  send(String.t, String.t) ::  {:ok} | {:error, String.t}
end