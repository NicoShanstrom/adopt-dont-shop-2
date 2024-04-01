require 'rails_helper'

RSpec.describe 'Admin Application Show page' do
  before(:each) do
    @app_1 = Application.create!(name: "Nico", street_address: "398 sand hill rd", city: "Asheville", state: "North Carolina", zip_code: "28806", description: "I have a house", status: "Pending" )
    @app_2 = Application.create!(name: "Luis", street_address: "12907 conquistador loop", city: "Tampa", state: "Florida", zip_code: "34610", description: " I have a house", status: "In Progress")
    @app_3 = Application.create!(name: "Nicholas", street_address: "12907 conquistador loop", city: "Tampa", state: "Florida", zip_code: "34610", description: " I have a house", status: "Pending")
    
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "Miami Shelter", city: "Miami, FL", foster_program: true, rank: 3)
    @shelter_3 = Shelter.create!(name: "Land-O-Lakes Shelter", city: "Tampa, FL", foster_program: true, rank: 3)
    
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter_2.id)
    @pet_3 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lucy", shelter_id: @shelter_2.id)
    
    @pet_app_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_2.id)
    @pet_app_2 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_3.id)
    @pet_app_3 = PetApplication.create!(application_id: @app_2.id, pet_id: @pet_1.id)
  end
  # 12. Approving a Pet for Adoption
  it 'has a button to approve the application for that specific pet' do
    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    visit "/admin/applications/#{@app_1.id}"
    # For every pet that the application is for, I see a button to approve the application for that specific pet
    within '.pets' do
      expect(page).to have_content("Lobster")
      expect(page).to have_content("Lucy")
      expect(page).to have_button("Approve: Lobster")
      expect(page).to have_button("Approve: Lucy")
      # When I click that button
      click_button("Approve: Lobster")
    end
    # Then I'm taken back to the admin application show page
    expect(current_path).to eq("/admin/applications/#{@app_1.id}")
    # And next to the pet that I approved, I do not see a button to approve this pet
    within '.pets' do
      expect(page).to have_content("Lobster")
      expect(page).to have_content("Lucy")
      expect(page).to_not have_button("Approve: Lobster")
      expect(page).to have_button("Approve: Lucy")
      # And instead I see an indicator next to the pet that they have been approved
      expect(page).to have_content("Lobster: Approved")
    end
  end

  # 13. Rejecting a Pet for Adoption
  it "rejects a pet for an application" do
    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    visit "/admin/applications/#{@app_1.id}"
    # For every pet that the application is for, I see a button to reject the application for that specific pet
    within '.pets' do
      expect(page).to have_content("Lobster")
      expect(page).to have_button("Reject: Lobster")

      # When I click that button
      click_button("Reject: Lobster")
    end
    # Then I'm taken back to the admin application show page
    expect(current_path).to eq("/admin/applications/#{@app_1.id}")
    # And next to the pet that I rejected, I do not see a button to approve or reject this pet
    within '.pets' do
      expect(page).to_not have_button("Reject: Lobster")
      # And instead I see an indicator next to the pet that they have been rejected
      expect(page).to have_content("Lobster: Rejected")
    end
  end
end