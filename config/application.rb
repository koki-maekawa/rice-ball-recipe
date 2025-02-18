require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.generators do |g|
      g.assets false             # JavaScriptやCSSなどのアセット関連ファイルを生成しない
      g.helper false             # ヘルパーファイルを生成しない
      g.test_framework :rspec,   # テストフレームワークとしてRSpecを使用
        fixtures: false,         # テスト用のfixtureファイルを生成しない
        view_specs: false,       # ビューのテストスペックファイルを生成しない
        helper_specs: false,     # ヘルパーのテストスペックファイルを生成しない
        routing_specs: false,    # ルーティングのテストスペックファイルを生成しない
        request_specs: false     # リクエストのテストスペックファイルを生成しない
    end
  end
end
