defmodule AlipayTest do
  use ExUnit.Case

  test "sign" do
    policy = %Alipay{
      private_key: "-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQDfn/38II4qsQX79LJxu2K6HlISBlqPRE+3w8ZqtTEvQVmLcNxlCK1M+lXH7CphjgHNpzj8qJ7LeUIGAdSkMYGytQIXkD0e0DBtrnR61Mf2BRUpdQjAkFjCdB0jof29wgdr/UXM/fEQzcT2eXDK+sbW+AuOH989v9eIB0A+YPzx+QIDAQABAoGBAK0e/1GhIm6KfUeBOGQz3UqZDpBFuvYOvGhXd9REUb9zqA77YKQXA5MEekQ74NOFTIAZZVS0dbqwNRzRbf1vFigAv99ESFKxkh26rrkJu5F7mCSZrlS/HI2X/mie1Q9XkfEQ11gnvE9odQZiCv4/yvymxf3v0QKH3NH5VXft+OgBAkEA9dYl/1QKKmew6zDp/S5NMWCQJyM/bgMEhUnem2WMDLIkCEJQAlZKpewn+4yW/wV1mj/c02lH/nCb7u07iPaRiQJBAOjew5vaB4Tm7zx1wxhnjJ2RE3EpU7HzL2ssEkJtqGadAgeKGmoF3m6Log2/jKcuyiWsgaNAqk6vh/TtHxUicPECQC1fmSPHHxk0ijLelFFmeljiubh/iPWFGRCA0dVcqLyvJHdhxeKoip6VN8v15uiq2Une/6MFi4QqxJ0UrChbWgECQEcjzpQtHkDun8VToH8zGxUDvfHDE0t4pFLUStu6TkjSzEzrVrhvBI224JHco6ZrN9wcgBoUZjLVku4zBlzZgbECQGkr9kgYG3IjWKJ+iNdlGsIBsMBrKeO4Z16JcQv5XPSLkeMrl9H0iWupSYHcLiG/ynls6t5bot2xhqhkT1YCXZI=\n-----END RSA PRIVATE KEY-----"
    }

    sign = Alipay.sign(policy, %{
      method: "alipay.mobile.public.menu.add",
      app_id: "2014072300007148",
      charset: "GBK",
      sign_type: "RSA2",
      timestamp: "2014-07-24 03:07:50",
      biz_content: "{\"button\":[{\"actionParam\":\"ZFB_HFCZ\",\"actionType\":\"out\",\"name\":\"话费充值\"},{\"name\":\"查询\",\"subButton\":[{\"actionParam\":\"ZFB_YECX\",\"actionType\":\"out\",\"name\":\"余额查询\"},{\"actionParam\":\"ZFB_LLCX\",\"actionType\":\"out\",\"name\":\"流量查询\"},{\"actionParam\":\"ZFB_HFCX\",\"actionType\":\"out\",\"name\":\"话费查询\"}]},{\"actionParam\":\"http://m.alipay.com\",\"actionType\":\"link\",\"name\":\"最新优惠\"}]}",
      version: "1.0"
    })

    assert sign == "UNzS7GMWf7WyrHAo5UanDj+Uv1xDjEBcD5QL8zLLybT8k1Kw4/O06pW1xJmbSsf/Y42b0ih4ssjvAALQdIjvG+YMADB/nlvlOByX0qWzXgLM4i+rNNfC1Hv87wYe3YxNtGAP0IWohk7/qK+CIM3vydt/n7mELXjKWEzoQw76gl0="
  end
end
