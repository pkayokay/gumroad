module ApplicationHelper
  def is_consumer_side?
    controller_name == "pages"
  end

  def bg_color
    product_page = controller_name == "pages" && action_name == "product"
    profile_page = controller_name == "pages" && action_name == "profile"
    tips_page = controller_name == "pages" && action_name == "tips"
    product_page || profile_page || tips_page ? "bg-white" : "bg-body"
  end
end
