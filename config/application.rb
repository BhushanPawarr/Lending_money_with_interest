require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LendingSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.active_job.queue_adapter = :sidekiq
  end
  
# Sidekiq::Scheduler.enabled = true
# Sidekiq.configure_server do |config|
#   config.on(:startup) do
#     Sidekiq.schedule = YAML.load_file(File.expand_path('../sidekiq.yml', __FILE__))
#     Sidekiq::Scheduler.reload_schedule!
#   end

#   Sidekiq.configure_client do |config|
#     config.redis = {
#       url: Rails.application.credentials.config[:REDIS_URL],
#       protocol: 2,
#     }
#   end
# end

end
