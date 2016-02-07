defmodule Sms do
	use GenServer

	@name __MODULE__

  	@doc """
  	Starts the type server.
  	"""
  	@spec start_link :: GenServer.on_start
  	def start_link do
  		GenServer.start_link(__MODULE__, [], name: @name)
  	end

  	@spec start_link_raw :: GenServer.on_start
  	def start_link_raw do
  		GenServer.start_link(__MODULE__, [])
  	end

  	@doc """
  	Send sms to phone number.

  	If failed, will response with reason
  	"""
  	@spec send(phone :: String.t, message :: String.t, server :: GenServer.on_start) :: {:ok} | {:error, String.t}
  	def send(phone, message, server \\ @name) do
  		GenServer.call(server, {:send, phone, message})
  	end

  	def init(_) do
  		{:ok, {}}
  	end

  	def handle_call(w = {:send, phone, message}, from, state) do
  		case Application.get_env(:sms, :provider) do
  			nil -> 
  				{:reply, {:error, "should set sms provider in your config file"}, state}
  			provider -> 
  				{:reply, provider.send(phone, message), state}
  		end
  	end
end
