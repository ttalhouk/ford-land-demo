require 'rails_helper'

RSpec.feature "Showing amenities" do
  before do
    @user = User.create({email:"example@example.com", password:"123456", password_confirmation:"123456"})
    @admin = User.create({email:"admin@example.com", password:"123456", password_confirmation:"123456", admin:true})
    #
    picture_params = {image:File.new("spec/fixtures/desk.jpg"), caption:"desk"}



    @amenity = Amenity.create({name: "Amenity 1", description: "Amenity 1 Description"})

    @amenity.pictures.create(picture_params)

  end

  scenario "with amenities created and user not signed in" do
    visit '/amenities'
    click_link @amenity.name

    expect(current_path).to eq(amenity_path(@amenity))

    expect(page).to have_content(@amenity.name)
    expect(page).to have_content(@amenity.description)

    expect(page).to have_link("Back")

  end
end
