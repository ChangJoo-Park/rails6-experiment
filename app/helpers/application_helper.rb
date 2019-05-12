# frozen_string_literal: true

module ApplicationHelper
  def adorable_avatar(email, size = 285)
    "<img src=\"https://api.adorable.io/avatars/285/#{email}\" class=\"img-fluid rounded\" width=\"#{size}px\">".html_safe
  end
end
