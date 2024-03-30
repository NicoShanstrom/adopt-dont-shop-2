require "rails_helper"

RSpec.describe 'Application Show page' do
  before(:each) do
    @app_1 = Application.create!(name: "Nico", street_address: "398 sand hill rd", city: "Asheville", state: "North Carolina", zip_code: "28806", description: "I have a house", status: "In Progress" )
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter_1.id)
    
    @pet_app_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_1.id)
    @app_2 = Application.create!(name: "Luis", street_address: "12907 conquistador loop", city: "Tampa", state: "Florida", zip_code: "34610", description: " I have a house", status: "In Progress")
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

  # 4. Searching for Pets for an Application
  it "Searching for Pets for an Application" do
    # As a visitor
    # When I visit an application's show page
    visit "/applications/#{@app_1.id}"
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    expect(page).to have_content("Add a Pet to this Application")
    # In that section I see an input where I can search for Pets by name
    expect(page).to have_content("Search for an specific Pet:")
    # When I fill in this field with a Pet's name
    fill_in "search", with: "Lucille Bald"
    # And I click submit,
    click_button("Find pet")
    # Then I am taken back to the application show page
    expect(current_path).to eq("/applications/#{@app_1.id}")
    # And under the search bar I see any Pet whose name matches my search
    within '.pets_found' do
      expect(page).to have_content("Lucille Bald")
    end
  end

  # 5. Add a Pet to an Application
  it "can search for pets and have an adopt pet button" do
    # As a visitor
    # When I visit an application's show page
    visit "/applications/#{@app_1.id}"
    # And I search for a Pet by name
    expect(page).to have_content("Add a Pet to this Application")
    fill_in "search", with: "Lucille Bald"
    # And I see the names Pets that match my search
    click_button("Find pet")
    # Then next to each Pet's name I see a button to "Adopt this Pet"
    within '.pets_found' do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_link(@pet_1.name)
      expect(page).to have_button("Adopt this Pet")
      # When I click one of these buttons
      click_button("Adopt this Pet")
    end
    # Then I am taken back to the application show page
    expect(current_path).to eq("/applications/#{@app_1.id}")
    # And I see the Pet I want to adopt listed on this application
    expect(page).to have_content(@pet_1.name)
  end

  # 6. Submit an Application
  it "has a form where you can update the description and the status" do
    # As a visitor
    # When I visit an application's show page
    visit "/applications/#{@app_1.id}"
    # And I have added one or more pets to the application
    expect(page).to have_content(@pet_1.name)
    within '.submission' do
      # Then I see a section to submit my application
      expect(page).to have_content("Submit this Application")
      # And in that section I see an input to enter why I would make a good owner for these pet(s)
      expect(page).to have_content("Why would you make a good owner for these pets?")
      # When I fill in that input
      fill_in "description", with: "I love dogs"
      # And I click a button to submit this application
      click_button("Submit")
    end
    # Then I am taken back to the application's show page
    expect(current_path).to eq("/applications/#{@app_1.id}")
    # And I see an indicator that the application is "Pending"
    expect(page).to have_content("Status: Pending")
    # And I see all the pets that I want to adopt
    expect(page).to have_content(@pet_1.name)
    # And I do not see a section to add more pets to this application
    expect(page).to_not have_css(".application")
  end
end