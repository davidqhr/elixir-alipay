defmodule Alipay.Mapi.Policy do
  @moduledoc """
  用于存储Mapi下请求的配置
  """
  defstruct pid: "", key: "", sign_type: "", private_key: ""
end

defmodule Alipay.Mapi do

  @moduledoc """
  本模块的方法对应着 [https://mapi.alipay.com/gateway.do](https://mapi.alipay.com/gateway.do) 接口下的请求

  需要参数:

  - pid
  - key
  - private_key (可选，sign_type为RSA/DSA时使用)
  - alipay_public_key (可选)

  请在 [https://openhome.alipay.com/platform/keyManage.htm?keyType=partner](https://openhome.alipay.com/platform/keyManage.htm?keyType=partner) 获取/设置

  """

  @url "https://mapi.alipay.com/gateway.do"

  @doc """
  即时到账接口

  文档 [https://doc.open.alipay.com/docs/doc.htm?treeId=62&articleId=103566&docType=1](https://doc.open.alipay.com/docs/doc.htm?treeId=62&articleId=103566&docType=1)
  """
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
    "#{@url}?#{URI.encode_query(params)}"
  end

  @doc """
  验签

  文档 [https://doc.open.alipay.com/docs/doc.htm?treeId=62&articleId=104741&docType=1](https://doc.open.alipay.com/docs/doc.htm?treeId=62&articleId=104741&docType=1)
  """
  def varify?(policy, alipay_notification_params) do
    sign = alipay_notification_params["sign"]

    params = Map.drop(alipay_notification_params, ["sign", "sign_type"])
    sign == sign(policy, params)[:sign]
  end

  @doc """
  数据签名

  文档 [https://doc.open.alipay.com/docs/doc.htm?treeId=62&articleId=104741&docType=1](https://doc.open.alipay.com/docs/doc.htm?treeId=62&articleId=104741&docType=1)
  """
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