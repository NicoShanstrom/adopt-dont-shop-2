require "rails_helper"

RSpec.describe "Application new page" do
  it "" do
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
