ACTIVE_MERCHANT_OPTIONS = YAML.load_file("#{::Rails.root.to_s}/config/activemerchant.yml")[Rails.env].to_options

::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(ACTIVE_MERCHANT_OPTIONS)

#talk to test server if not in production
if Rails.env.to_sym == :production
  ActiveMerchant::Billing::Base.mode = :production
else
  ActiveMerchant::Billing::Base.mode = :test
end

#we only sell in euros €
ActiveMerchant::Billing::PaypalExpressGateway.default_currency = 'EUR'
