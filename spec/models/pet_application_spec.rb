require "rails_helper"

RSpec.describe PetApplication, type: :model do
  describe "relationship" do
    it { should belong_to(:application) }
    it { should belong_to(:pet) }
  end

  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  before(:each) do
    @app_3 = Application.create!(name: "Nicholas", street_address: "12907 conquistador loop", city: "Tampa", state: "Florida", zip_code: "34610", description: " I have a house", status: "Pending")
    @shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_application = PetApplication.create!(application_id: @app_3.id, pet_id: @pet.id)  
  end

  it "approve a pet for adoption" do
    expect(@pet_application.status).to eq("Not Approved")
    @pet_application.approve_pet
    expect(@pet_application.status).to eq("Approved")
  end

  it "reject a pet for adoption" do
    expect(@pet_application.status).to eq("Not Approved")
    @pet_application.reject_pet
    expect(@pet_application.status).to eq("Rejected")
  end
end