module ApplicationHelper
  def adorable_avatar(email, size = 285)
    "<img src=\"https://api.adorable.io/avatars/#{285}/#{email}\" style=\"height:#{size}px;width:#{size}px\">".html_safe
  end
end
