class Page

  def initialize(driver)
    @driver = driver
  end

  def load_url(url)
    @driver.get url
  end

  def wait_until(seconds=5)
    Selenium::WebDriver::Wait.new(:timeout => seconds).until { yield }
  end

  def find(locator)
    begin
      wait_until { @driver.find_element(locator) }
    rescue Selenium::WebDriver::Error::TimeoutError
      wait_until { @driver.find_element(locator) }
    end
  end

  def click(locator)
    find(locator).click
  end

  def fill_text(text, locator)
    find(locator).send_keys text
  end

  def is_displayed?(locator)
    begin
      find(locator).displayed?
    rescue Selenium::WebDriver::Error::TimeoutError
      return false
    else
      return true
    end
  end

  def ui_element_displayed?(ui_element)
    is_displayed? ui_element
  end

  def get_text(locator)
    wait_until { @driver.find_element(locator).text }
  end
end