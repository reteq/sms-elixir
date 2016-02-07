defmodule SmsTest do
  use ExUnit.Case, async: true
  doctest Sms

  setup tags do
    if !tags[:noprovider] do
    	#TODO add provider automatically
    end

    {:ok, pid} = Sms.start_link
    {:ok, pid: pid}
  end

  @tag :noprovider
  test "no sms provider setting", %{pid: _pid} do
  	assert {:error, _} = Sms.send("12345678901", "whatever")
  end
end
