if Rails.env == "development"
  ActiveMerchant::Billing::Base.mode = :test

  login = 'TestMerchant'
  password= 'password'
elsif Rails.env == "production"
  login = 'TestMerchant'
  password= 'password'
end
GATEWAY = ActiveMerchant::Billing::TrustCommerceGateway.new({
      login: login,
      password: password
})