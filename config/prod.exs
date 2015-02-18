use Mix.Config

config :reception, Reception.Endpoint,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT") || 4000],
  secret_key_base: "H3GMtn+QWkKYdKO2Br8Xgb4USd5Lz6QprgelqH6n/OnHeXsYQ0c1hGiqm9QHgDNE",
  server: true

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section:
#
#  config:reception, Reception.Endpoint,
#    ...
#    https: [port: 443,
#            keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#            certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.
  

# Do not pring debug messages in production
config :logger, level: :info

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :reception, Reception.Endpoint, server: true
#
