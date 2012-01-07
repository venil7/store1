pay_day_config = APP_CONFIG["payday_invoice"]
Payday::Config.default.invoice_logo = "#{::Rails.root.to_s}/#{pay_day_config["invoice_logo"]}"
Payday::Config.default.company_name = pay_day_config["company_name"]
Payday::Config.default.company_details = pay_day_config["company_details"]
Payday::Config.default.currency = pay_day_config["currency"]
Payday::Config.default.date_format = pay_day_config["date_format"]