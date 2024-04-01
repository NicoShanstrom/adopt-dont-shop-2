require "rails_helper"

RSpec.describe Application, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end
  
  describe "relationships" do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  before(:each) do
    @app = Application.create!(name: "Nico", street_address: "398 sand hill rd", city: "Asheville", state: "North Carolina", zip_code: "28806", description: "I have a house", status: "In Progress" )
    @shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lobster", shelter_id: @shelter.id)
    @pet_application_1 = PetApplication.create!(application_id: @app.id, pet_id: @pet.id, status: "Approved")
    @pet_application_2 = PetApplication.create!(application_id: @app.id, pet_id: @pet_2.id, status: "Rejected")
  end

  describe "instance methods" do
    describe "#pet_approved?" do
      it "returns a boolean value true if approved and false if not" do
        expect(@app.pet_approved?(@pet)).to eq(true)
        expect(@app.pet_approved?(@pet_2)).to eq(false)
      end
    end 
    
    describe "#pet_rejected?" do
      it 'returns a boolean value true if pet is rejected and false if not' do
        expect(@app.pet_rejected?(@pet_2)).to eq(true)
        expect(@app.pet_rejected?(@pet)).to eq(false)
      end
    end
  end
end