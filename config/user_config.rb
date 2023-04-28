require 'base64'

DEFAULT_USER = 'standard_user'
DEFAULT_PASSWORD = 'c2VjcmV0X3NhdWNl'



def get_default_password
  Base64.decode64 DEFAULT_PASSWORD
end