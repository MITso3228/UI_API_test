require 'selenium-webdriver'
require 'rspec'

RSpec.configure do |config|
  config.before(:each) do
    options = Selenium::WebDriver::Chrome::Options.new

    @driver = Selenium::WebDriver.for :chrome, options: options

    target_size = Selenium::WebDriver::Dimension.new(1024, 768)
    @driver.manage.window.size = target_size
    @driver.manage.timeouts.implicit_wait = 5
    @driver.manage.timeouts.page_load = 15
  end

  config.after(:each) do
    @driver.quit
  end
end