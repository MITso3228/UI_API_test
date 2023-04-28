require_relative 'page'

class Login < Page

  LOGIN_PAGE_URL = 'https://www.saucedemo.com/'

  # header
  LOGIN_LOGO = { css: 'div.login_logo' }

  # text fields
  USERNAME_FIELD = { id: 'user-name' }
  PASSWORD_FIELD = { id: 'password' }
  LOGIN_BUTTON = { id: 'login-button' }

  # errors
  X_MARK_USERNAME = { css: '#user-name.input_error' }
  X_MARK_PASSWORD = { css: '#password.input_error' }
  ERROR_MESSAGE = { css: 'div.error' }

  # errors text
  CREDENTIALS_DONT_MATCH_TEXT = "Epic sadface: Username and password do not match any user in this service"
  USERNAME_IS_REQUIRED_TEXT = "Epic sadface: Username is required"
  PASSWORD_IS_REQUIRED_TEXT = "Epic sadface: Password is required"

  def open_login_page
    load_url LOGIN_PAGE_URL
  end

  def click_login_button
    click LOGIN_BUTTON
  end

  def fill_username(username)
    fill_text(username, USERNAME_FIELD)
  end

  def fill_password(password)
    fill_text(password, PASSWORD_FIELD)
  end

  def login_errors_ui
    yield X_MARK_USERNAME
    yield X_MARK_PASSWORD
    yield ERROR_MESSAGE
  end
end # Login