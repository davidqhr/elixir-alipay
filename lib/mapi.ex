defmodule Alipay.Mapi.Policy do
  defstruct pid: "", key: "", sign_type: "", private_key: ""
end

defmodule Alipay.Mapi do

  @url "https://mapi.alipay.com/gateway.do"

  def create_direct_pay_by_user_url(policy, %{
      out_trade_no: _out_trade_no,
      subject: _subject
    } = params) do

    params = %{
      service: "create_direct_pay_by_user",
      partner: policy.pid,
      _input_charset: "utf-8",
      payment_type: "1",
      seller_id: policy.pid,
    } |> Map.merge(params)

    params = sign(policy, params)
    URI.encode_query(params)
  end

  def sign(policy, params) do
    joined_string = Enum.map(params, fn({k, v}) ->
      "#{k}=#{v}"
    end) |> Enum.join("&")

    sign = case policy.sign_type do
      "MD5" -> "#{joined_string}#{policy.key}" |> :erlang.md5 |> Base.encode16 |> String.downcase
      "RSA" -> Alipay.Utils.private_key_sign(joined_string, :sha1, policy.private_key)
    end

    params
    |> Map.put(:sign_type, policy.sign_type)
    |> Map.put(:sign, sign)
  end
end