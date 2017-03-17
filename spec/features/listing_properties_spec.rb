require 'rails_helper'

RSpec.feature "Listing properties" do
  before do
    @user = User.create({email:"example@example.com", password:"123456", password_confirmation:"123456"})
    @admin = User.create({email:"admin@example.com", password:"123456", password_confirmation:"123456", admin:true})
    #
    picture_params = {image:File.new("spec/fixtures/desk.jpg"), caption:"desk"}



    @property = Property.create({name: "Property 1", description: "Property 1 Description", available: true})
    @property2 = Property.create({name: "Property 2", description: "Property 2 Description", available: false})
    @property.pictures.create(picture_params)
    @property2.pictures.create(picture_params)

  end

  scenario "with properties created and user not signed in" do
    visit '/properties'

    expect(page).to have_content(@property.name)
    expect(page).to have_content(@property.description)
    expect(page).to_not have_content(@property2.name)
    expect(page).to_not have_content(@property2.description)

  end

  scenario "a loged in user views all properties" do
    login_as(@user)
    visit '/properties'


    expect(page).to have_content(@property.name)
    expect(page).to have_content(@property.description)
    expect(page).to_not have_content(@property2.name)
    expect(page).to_not have_content(@property2.description)

  end

  scenario "an admin views all properties" do
    login_as(@admin)
    visit '/properties'


    expect(page).to have_content(@property.name)
    expect(page).to have_content(@property.description)
    expect(page).to have_content(@property2.name)
    expect(page).to have_content(@property2.description)

  end

  scenario "with no properties" do
    Property.delete_all
    visit '/properties'

    expect(page).to_not have_content(@property.name)
    expect(page).to_not have_content(@property.description)
    expect(page).to_not have_content(@property2.name)
    expect(page).to_not have_content(@property2.description)

    within("h3#no-properties") do
      expect(page).to have_content('No Properties Available')
    end
  end
end
