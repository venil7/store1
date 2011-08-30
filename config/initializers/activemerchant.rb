::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(:login => "seller_1310850880_biz_api1.gmail.com", :password => "1310850927", :signature => "AVO-1SY.tDOG.SuUpoUPxZE8c.t0AzCEH.Plq76OW6er9K5jmNRVCCqk")

#talk to test server if not in production
ActiveMerchant::Billing::Base.mode = :test unless Rails.env.to_sym == :production
#we only sell in pounds £
ActiveMerchant::Billing::PaypalExpressGateway.default_currency = 'GBP'
