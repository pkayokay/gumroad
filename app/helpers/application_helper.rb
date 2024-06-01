module ApplicationHelper
  def is_consumer_side?
    controller_name == "pages"
  end
end
