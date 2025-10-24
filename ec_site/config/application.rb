require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module EcSite
  class Application < Rails::Application
    config.load_defaults 8.0

    # タイムゾーン設定
    config.time_zone = "Tokyo"

    # lib以下をautoload対象に
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
