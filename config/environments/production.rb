Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = true
  config.assets.digest = true
  config.log_level = :debug
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'
  config.serve_static_assets = true
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
  config.action_mailer.delivery_method = :smtp 
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_options = { from: 'maxprofkom@gmail.com' }
  config.action_mailer.default_url_options = { :host => 'cinema-booking.herokuapp.com' }
  config.action_mailer.smtp_settings = {
        :address        => 'smtp.gmail.com',
        :domain         => 'cinema-booking.herokuapp.com',
        :port           => 587,
        :user_name      => ENV['maxprofkom@gmail.com'],
        :password       => ENV['yiykjrgpxhvvwfmy'],
        :authentication => "plain",
        :enable_starttls_auto => true
  }
  config.action_mailer.raise_delivery_errors = true
  config.secret_key = '12345678' if Rails.env == 'production'
end
