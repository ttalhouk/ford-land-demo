module ApplicationHelper
  def is_admin?
    return current_user.admin
  end
end
