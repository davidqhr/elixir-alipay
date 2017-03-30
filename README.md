# Alipay

Alipay Elixir SDK

## Support API

- [即时到账](https://doc.open.alipay.com/docs/doc.htm?treeId=62&articleId=103566&docType=1)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `alipay` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:alipay, git: "https://github.com/davidqhr/elixir-alipay" }]
    end
    ```

  2. Ensure `alipay` is started before your application:

    ```elixir
    def application do
      [applications: [:alipay]]
    end
    ```
## Usage

```elixir
policy = %Alipay.Mapi.Policy{ pid: "", key: "", sign_type: "MD5" }

url = Alipay.Mapi.create_direct_pay_by_user_url(policy, %{
  out_trade_no: "no",
  subject: "subject",
  notify_url: "https://example.com",
  return_url: "https://example.com",
  total_fee: "10.00"
})

# open the url in a browser
```