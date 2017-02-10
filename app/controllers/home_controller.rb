class HomeController < ApplicationController
  def index
    @amenities = Amenity.all
    @gallery = Gallery.last || Gallery.new
  end
end
