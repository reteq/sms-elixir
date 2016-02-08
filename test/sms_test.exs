defmodule SmsTest do
  use ExUnit.Case, async: true
  doctest Sms

  setup tags do
    if !tags[:noprovider] do
    	Application.put_env(:sms, :provider, Sms.Yunpian)
    end

    {:ok, pid} = Sms.start_link
    on_exit fn -> Application.delete_env(:sms, :provider) end
    {:ok, pid: pid}
  end

  @tag :noprovider
  test "no sms provider setting", %{pid: _pid} do
  	assert {:error, _} = Sms.send("12345678901", "whatever")
  end

  test "without username apikey or password", %{pid: _pid} do
  	assert {:error, _reason} = Sms.send("12345678901", "whatever")
  end
end
