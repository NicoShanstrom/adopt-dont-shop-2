require "rails_helper"

RSpec.describe "the pets index" do
  it "lists all the pets with their attributes" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.breed)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(shelter.name)

    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.breed)
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(shelter.name)
  end

  it "only lists adoptable pets" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to_not have_content(pet_3.name)
  end

  it "displays a link to edit each pet" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content("Edit #{pet_1.name}")
    expect(page).to have_content("Edit #{pet_2.name}")

    click_link("Edit #{pet_1.name}")

    expect(page).to have_current_path("/pets/#{pet_1.id}/edit")
  end

  it "displays a link to delete each pet" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content("Delete #{pet_1.name}")
    expect(page).to have_content("Delete #{pet_2.name}")

    click_link("Delete #{pet_1.name}")

    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content(pet_1.name)
  end

  it "has a text box to filter results by keyword" do
    visit "/pets"
    expect(page).to have_button("Search")
  end

  it "lists partial matches as search results" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: shelter.id)

    visit "/pets"

    fill_in "Search", with: "Ba"
    click_on("Search")

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
  end

  # 2. Starting an Application
  it "has a link to the new application form" do
    # As a visitor
    # When I visit the pet index page
    visit "/pets"
    # Then I see a link to "Start an Application"
    expect(page).to have_link("Start an Application")
    # When I click this link
    click_link("Start an Application")
    # Then I am taken to the new application page where I see a form
    expect(current_path).to eq("/applications/new")

    visit "/applications/new"
    # When I fill in this form with my:
    #   - Name
    fill_in "name", with: "Nico"
    #   - Street Address
    fill_in "street_address", with: "398 sand hill rd"
    #   - City
    fill_in "city", with: "Asheville"
    #   - State
    fill_in "state", with: "North Carolina"
    #   - Zip Code
    fill_in "zip_code", with: "28806"
    #   - Description of why I would make a good home
    fill_in "description", with: "I have a house"
    # And I click submit
    # save_and_open_page
    click_button("Submit")

    # Then I am taken to the new application's show page
    expect(current_path).to_not eq("/applications/new")
    # And I see my Name, address information, and description of why I would make a good home
    # And I see an indicator that this application is "In Progress"
    expect(page).to have_content("Nico")
    expect(page).to have_content("398 sand hill rd")
    expect(page).to have_content("Asheville")
    expect(page).to have_content("North Carolina")
    expect(page).to have_content("28806")
    expect(page).to have_content("I have a house")
    expect(page).to have_content("In Progress")
  end
end
