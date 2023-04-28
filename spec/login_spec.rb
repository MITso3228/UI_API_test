require_relative 'spec_helper'
require_relative '../pages/login_page'
require_relative '../pages/home_page'
require_relative '../config/user_config'

describe 'Login Page - ' do
  let(:page) { Page.new(@driver) }
  let(:login_page) { Login.new(@driver) }
  let(:home_page) { Home.new(@driver) }

  it 'login with correct credentials', :smoke do
    # Open Login Page
    login_page.open_login_page

    # Fill username and password
    login_page.fill_username(DEFAULT_USER)
    login_page.fill_password(get_default_password)

    # Click Login button
    login_page.click_login_button

    # Verify Home Page is opened
    home_page.ui_elements do |ui_element|
      expect(page.ui_element_displayed?(ui_element)).to be_truthy
    end
  end

  it 'login with incorrect credentials', :smoke do
    # Open Login Page
    login_page.open_login_page

    # Fill username and password
    login_page.fill_username(DEFAULT_USER)
    login_page.fill_password(get_default_password + '1')

    # Click Login button
    login_page.click_login_button

    # Verify Login Page contains errors
    login_page.login_errors_ui do |ui_element|
      expect(page.ui_element_displayed?(ui_element)).to be_truthy
    end

    expect(page.get_text(Login::ERROR_MESSAGE)).to eq(Login::CREDENTIALS_DONT_MATCH_TEXT)
  end

  it 'required fields', :smoke do
    # Open Login Page
    login_page.open_login_page

    # Click Login button
    login_page.click_login_button

    # Verify Login Page contains errors
    login_page.login_errors_ui do |ui_element|
      expect(page.ui_element_displayed?(ui_element)).to be_truthy
    end

    expect(page.get_text(Login::ERROR_MESSAGE)).to eq(Login::USERNAME_IS_REQUIRED_TEXT)

    # Fill username
    login_page.fill_username(DEFAULT_USER)

    # Click Login button
    login_page.click_login_button

    # Verify Login Page contains Errors
    login_page.login_errors_ui do |ui_element|
      expect(page.ui_element_displayed?(ui_element)).to be_truthy
    end

    expect(page.get_text(Login::ERROR_MESSAGE)).to eq(Login::PASSWORD_IS_REQUIRED_TEXT)
  end
end