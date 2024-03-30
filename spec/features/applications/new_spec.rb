require "rails_helper"

RSpec.describe "Application new page" do
  # 3. Starting an Application, Form not Completed
  it "" do
    # As a visitor
    # When I visit the new application page
    visit "/applications/new"
    # And I fail to fill in any of the form fields
    #   - Name
    fill_in "name", with: "Nico"
    # And I click submit
    click_button("Submit")
    # Then I am taken back to the new applications page
    expect(current_path).to eq("/applications/new")
    # And I see a message that I must fill in those fields.
    expect(page).to have_content("Fill in the blanks")
  end
end
