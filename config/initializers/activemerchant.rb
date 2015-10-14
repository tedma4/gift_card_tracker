if Rails.env == "development"
  ActiveMerchant::Billing::FirstdataE4Gateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")  
  ActiveMerchant::Billing::FirstdataE4Gateway.wiredump_device.sync = true 
  ActiveMerchant::Billing::Base.mode = :test

  login = ENV['gateid']
  password= ENV['password']
elsif Rails.env == "production"
  login = ENV['gateid']
  password= ENV['password']
end
GATEWAY = ActiveMerchant::Billing::FirstdataE4Gateway.new({
      login: login,
      password: password
})