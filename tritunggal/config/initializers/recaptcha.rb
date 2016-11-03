# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.public_key  = '6LcujQkUAAAAALme3zgiMaSxqeeZR3ASFQqZixZc'
  config.private_key = '6LcujQkUAAAAADNmJJWIcAhV5dvBLDTG1wdmcZ93'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end