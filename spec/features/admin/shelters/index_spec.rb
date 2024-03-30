require 'rails_helper'

RSpec.describe 'Admin shelters index' do
  before(:each) do
    @app_1 = Application.create!(name: "Nico", street_address: "398 sand hill rd", city: "Asheville", state: "North Carolina", zip_code: "28806", description: "I have a house", status: "In Progress" )
    @app_2 = Application.create!(name: "Luis", street_address: "12907 conquistador loop", city: "Tampa", state: "Florida", zip_code: "34610", description: " I have a house", status: "In Progress")
    @app_3 = Application.create!(name: "Nicholas", street_address: "12907 conquistador loop", city: "Tampa", state: "Florida", zip_code: "34610", description: " I have a house", status: "Pending")
    
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "Miami Shelter", city: "Miami, FL", foster_program: true, rank: 3)
    @shelter_3 = Shelter.create!(name: "Land-O-Lakes Shelter", city: "Tampa, FL", foster_program: true, rank: 3)
    
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter_1.id)
    @pet_3 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lucy", shelter_id: @shelter_2.id)
    
    @pet_app_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_1.id)
    @pet_app_2 = PetApplication.create!(application_id: @app_3.id, pet_id: @pet_3.id)
  end

  # 10. Admin Shelters Index
    it 'shows all shelters in the system in reverse alphabetical order' do
      # As a visitor
      # When I visit the admin shelter index ('/admin/shelters')
      visit "/admin/shelters"
      # Then I see all Shelters in the system listed in reverse alphabetical order by name
      expect("Miami Shelter").to appear_before("Land-O-Lakes Shelter")
      expect("Land-O-Lakes Shelter").to appear_before("Aurora shelter")
      expect("Land-O-Lakes Shelter").to_not appear_before("Miami Shelter")
    end

  # 11. Shelters with Pending Applications
    it 'has a section for shelters with pending applications' do
      # As a visitor
      # When I visit the admin shelter index ('/admin/shelters')
      visit "/admin/shelters"
      # Then I see a section for "Shelters with Pending Applications"
      within '.pending-applications' do
        # And in this section I see the name of every shelter that has a pending application
        expect(page).to have_content("Pending Applications")
        expect(page).to have_content(@shelter_2.name)
        expect(page).to_not have_content(@shelter_1.name)
      end
    end
end