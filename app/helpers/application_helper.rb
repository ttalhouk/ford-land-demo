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

  def get_local_time(time)
    return time.in_time_zone("Pacific Time (US & Canada)").strftime("%l:%M %P - %m / %d / %Y")
  end

end
