defmodule Alipay do
  defstruct app_id: nil, key: nil, sign_type: nil, private_key: nil

  @moduledoc """
    This module is under development, DO NOT USE THIS MODULE IN PRODUCTION
  """
  @url "https://openapi.alipaydev.com/gateway.do"

  def precreate(policy, %{ :biz_content => _biz_content, :notify_url => _notify_url } = params) do

    params = %{
      :app_id     => policy.app_id,
      :method     => "alipay.trade.precreate",
      :charset    => "utf-8",
      :sign_type  => policy.sign_type || "RSA2",
      :version    => "1.0",
      :timestamp  => Alipay.Utils.current_timestamp(),
    } |> Map.merge(params)

    request(policy, params)
  end

  def request(policy, params) do
    params = Map.put(params, :biz_content, Poison.encode!(params[:biz_content]))
    params = Map.put(params, :sign, sign(policy, params))

    query = URI.encode_query(params)

    case HTTPoison.get("#{@url}?#{query}") do
      {:ok, res} -> Poison.decode!(res.body)
      other -> other
    end
  end

  def sign(policy, params) do
    joined_string = Enum.map(params, fn({k, v}) ->
      "#{k}=#{v}"
    end) |> Enum.join("&")

    Alipay.Utils.private_key_sign(joined_string, :sha256, policy.private_key)
  end
end
