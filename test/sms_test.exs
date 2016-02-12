defmodule SmsTest do
  use ExUnit.Case, async: true
  doctest Sms

  setup tags do
    if !tags[:noprovider] do
    	Application.put_env(:sms, :provider, Sms.Yunpian)
    end

    if tags[:yunpian] do
    	Application.put_env(:sms, :provider, Sms.Yunpian)
    	Application.put_env(:sms, :apikey, "Your API key")
    end

    {:ok, pid} = Sms.start_link
    on_exit fn -> 
    	Application.delete_env(:sms, :provider) 
    	Application.delete_env(:sms, :apikey) 
    end
    {:ok, pid: pid}
  end

  @tag :noprovider
  test "no sms provider setting", %{pid: _pid} do
  	assert {:error, "should set sms provider in your config file"} == Sms.send("12345678901", "whatever")
  end

  test "without apikey", %{pid: _pid} do
  	assert {:error, "no apikey set in config"} == Sms.send("12345678901", "fun at reteq", [tpl_id: 2])
  end

  @tag :yunpian
  test "yunpian" do
  	assert {:ok, _} = Sms.send("12345678901", "fun at reteq", [tpl_id: 2])
  end
end
