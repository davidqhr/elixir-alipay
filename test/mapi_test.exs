defmodule MapiTest do
  use ExUnit.Case

  test "create_direct_pay_by_user" do
    policy = %Alipay.Mapi.Policy{
      pid: "pid",
      key: "key",
      sign_type: "MD5"
    }

    Alipay.Mapi.create_direct_pay_by_user_url(policy, %{
      out_trade_no: "no",
      subject: "subject",
      notify_url: "https://example.com",
      return_url: "https://example.com",
      total_fee: "10.00"
    })
  end
end
