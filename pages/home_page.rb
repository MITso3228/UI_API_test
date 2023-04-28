require_relative 'page'

class Home < Page

  # header
  HOME_LOGO = { css: 'div.app_logo' }
  SHOPPING_CART_ICON = { id: 'shopping_cart_container' }
  BURGER_MENU_ICON = { id: 'react-burger-menu-btn' }
  PRODUCTS_LIST = { css: 'div.inventory_list' }

  def ui_elements
    yield HOME_LOGO
    yield SHOPPING_CART_ICON
    yield BURGER_MENU_ICON
    yield PRODUCTS_LIST
  end
end # Home