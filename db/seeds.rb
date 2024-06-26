# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
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
@pet_app_3 = PetApplication.create!(application_id: @app_3.id, pet_id: @pet_1.id)
@pet_app_4 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_1.id)

