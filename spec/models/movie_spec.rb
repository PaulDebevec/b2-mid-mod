require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "validations" do
    it {should validate_presence_of(:title)}
  end

  describe "relationships" do
    it {should belong_to(:studio)}
    it {should have_many(:actor_movies)}
    it {should have_many(:actors).through(:actor_movies)}
  end

  describe "model methods" do
    it "actors_by_age" do
      studio_1 = Studio.create(name: "Universal Studio")

      actor_2 = Actor.create!(name: "Chris Fisher", age:22)
      actor_3 = Actor.create!(name: "John Smith", age: 32)
      actor_4 = Actor.create!(name: "Anduin Wrynn", age: 28)

      movie_4 = studio_1.movies.create!(title: "Jurassic Park", creation_year: 1991, genre: "Thriller")

      actor_2.movies << movie_4
      actor_3.movies << movie_4
      actor_4.movies << movie_4

      expect(movie_4.actors_by_age).to eq([actor_3, actor_4, actor_2])
    end
  end
end
