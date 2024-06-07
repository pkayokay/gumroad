class Tip < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :target_user, class_name: "User"


  def user_display_name
    user&.display_name || email
  end
end
