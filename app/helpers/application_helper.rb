module ApplicationHelper
  def is_admin?
      return user_signed_in? ? current_user.admin : false
  end

  def amenities_list
    Amenity.all
  end
  def active_gallery
    Gallery.last || Gallery.new
  end

end
