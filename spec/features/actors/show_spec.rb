require 'rails_helper'

describe "Actors Show Page" do
  describe "As a visitor" do
    it "Shows the actors name, age, and list of movie names they are in" do
      studio_1 = Studio.create(name: "Universal Studio")
      studio_2 = Studio.create(name: "Disney")

      actor_1 = Actor.create!(name: "Daniel Mackey", age: 23)
      actor_2 = Actor.create!(name: "Chris Fisher", age:42)
      actor_3 = Actor.create!(name: "John Smith", age: 32)
      actor_4 = Actor.create!(name: "Anduin Wrynn", age: 28)

      movie_1 = studio_2.movies.create!(title: "A New Hope")
      movie_2 = studio_2.movies.create!(title: "The Empire Strikes Back")
      movie_3 = studio_2.movies.create!(title: "Spiderman")
      movie_4 = studio_1.movies.create!(title: "Jurassic Park")
      movie_5 = studio_1.movies.create!(title: "Jaws")

      actor_1.movies << movie_1
      actor_1.movies << movie_2
      actor_2.movies << movie_1
      actor_2.movies << movie_2
      actor_3.movies << movie_3
      actor_3.movies << movie_4
      actor_4.movies << movie_4
      actor_4.movies << movie_5

      visit "/actors/#{actor_1.id}"

      within "#actor-info" do
        expect(page).to have_content(actor_1.name)
        expect(page).to have_content(actor_1.age)
      end

      within "#movie-info" do
        expect(page).to have_content(movie_1.title)
        expect(page).to have_content(movie_2.title)
      end

      visit "/actors/#{actor_3.id}"

      within "#actor-info" do
        expect(page).to have_content(actor_3.name)
        expect(page).to have_content(actor_3.age)
      end

      within "#movie-info" do
        expect(page).to have_content(movie_3.title)
        expect(page).to have_content(movie_4.title)
      end
    end

    it "I see a unique list of all the actors this particular actor has worked with" do
      studio_2 = Studio.create(name: "Disney")

      actor_1 = Actor.create!(name: "Daniel Mackey", age: 23)
      actor_2 = Actor.create!(name: "Chris Fisher", age:42)
      actor_3 = Actor.create!(name: "John Smith", age: 32)
      actor_4 = Actor.create!(name: "Anduin Wrynn", age: 28)

      movie_1 = studio_2.movies.create!(title: "A New Hope", creation_year: 1978, genre: "Debatably-Space-Opera")
      movie_2 = studio_2.movies.create!(title: "The Empire Strikes Back", creation_year: 1982, genre: "Debatably-Space-Opera")

      actor_1.movies << movie_1
      actor_3.movies << movie_1
      actor_4.movies << movie_1

      actor_2.movies << movie_2
      actor_3.movies << movie_2

      visit "/actors/#{actor_1.id}"

      within "#worked-with" do
        expect(page).to have_content("#{actor_3.name}")
        expect(page).to have_content("#{actor_4.name}")
      end

      visit "/actors/#{actor_3.id}"

      within "#worked-with" do
        expect(page).to have_content("#{actor_1.name}")
        expect(page).to have_content("#{actor_2.name}")
        expect(page).to have_content("#{actor_4.name}")
      end
    end
  end
end

# When I visit an actor's show page
# I see a unique list of all of the actors this particular actor has worked with.
