module ApplicationHelper
  def is_admin?
    return current_user ? current_user.admin : false
  end

  def amenities_list
    Amenity.all
  end
end
