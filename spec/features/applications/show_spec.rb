require "rails_helper"

RSpec.describe 'Application Show page' do
    before(:each) do
        @app_1 = Application.create!(name: "Nico", street_address: "398 sand hill rd", city: "Asheville", state: "North Carolina", zip_code: "28806", description: "I have a house", status: "In Progress" )
        @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        
        @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter_1.id)
        @pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter_1.id)
        @pet_app_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_1.id)
    end
    describe 'User story 1' do
        it 'renders the applications attributes and pet names the application is for' do
            # Application Show Page
            # As a visitor
            # When I visit an applications show page
            visit "/applications/#{@app_1.id}"
            # Then I can see the following:
            # - Name of the Applicant
            expect(page).to have_content("Name: Nico")
            # - Full Address of the Applicant including street address, city, state, and zip code
            expect(page).to have_content("Street address: 398 sand hill rd")
            expect(page).to have_content("City: Asheville")
            expect(page).to have_content("State: North Carolina")
            expect(page).to have_content("Zip code: 28806")
            # - Description of why the applicant says they'd be a good home for this pet(s)
            expect(page).to have_content("Description: I have a house")
            # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
            expect(page).to have_content("Status: In Progress")
            # - names of all pets that this application is for (all names of pets should be links to their show page)
            expect(page).to have_content(@pet_1.name)
            expect(page).to have_link(@pet_1.name)
            click_link(@pet_1.name)
            expect(current_path).to eq("/pets/#{@pet_1.id}")
        end
    end
end