defmodule Alipay.Utils do
  def current_timestamp do
    {{year, month, day}, {hour, min, sec}} = :calendar.local_time
    :io_lib.format("~4..0B-~2..0B-~2..0B ~2..0B:~2..0B:~2..0B", [year, month, day, hour, min, sec]) |> to_string
  end

  def private_key_sign(text, alg, private_key) do
    pk = :public_key.pem_decode(private_key) |> hd |> :public_key.pem_entry_decode
    :public_key.sign(text, alg, pk) |> Base.encode64
  end
end