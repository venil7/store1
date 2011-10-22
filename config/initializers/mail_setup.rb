ActionMailer::Base.smtp_settings = APP_CONFIG["smtp_settings"].to_options
ActionMailer::Base.default_url_options[:host] = APP_CONFIG["email_host"]

