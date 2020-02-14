require 'rails_helper'

describe "Movie Show Page" do
  describe "As a visitor" do
    it "shows the movie title, creation year, and genre as well as the actor names in descending order by age" do
      studio_1 = Studio.create(name: "Universal Studio")
      studio_2 = Studio.create(name: "Disney")

      actor_1 = Actor.create!(name: "Daniel Mackey", age: 23)
      actor_2 = Actor.create!(name: "Chris Fisher", age:42)
      actor_3 = Actor.create!(name: "John Smith", age: 32)
      actor_4 = Actor.create!(name: "Anduin Wrynn", age: 28)

      movie_1 = studio_2.movies.create!(title: "A New Hope", creation_year: 1978, genre: "Debatably-Space-Opera")
      movie_2 = studio_2.movies.create!(title: "The Empire Strikes Back", creation_year: 1982, genre: "Debatably-Space-Opera")
      movie_3 = studio_2.movies.create!(title: "Spiderman", creation_year: 2014, genre: "Action")
      movie_4 = studio_1.movies.create!(title: "Jurassic Park", creation_year: 1991, genre: "Thriller")
      movie_5 = studio_1.movies.create!(title: "Jaws", creation_year: 1993, genre: "Thriller")

      actor_1.movies << movie_1
      actor_1.movies << movie_2
      actor_2.movies << movie_1
      actor_2.movies << movie_2
      actor_3.movies << movie_3
      actor_3.movies << movie_4
      actor_4.movies << movie_4
      actor_4.movies << movie_5

      visit "/movies/#{movie_1.id}"

      expect(page).to have_content(movie_1.title)

      within "#actors" do
        expect(page).to have_content(actor_1.name)
        expect(page).to have_content(actor_2.name)
      end

      visit "/movies/#{movie_4.id}"

      expect(page).to have_content(movie_4.title)

      within "#actors" do
        expect(page).to have_content(actor_3.name)
        expect(page).to have_content(actor_4.name)
      end
    end

    it "I see a form to input an actors name and when I fill in and submit, I'm
        redirected back to that movies show page where I see that actors name " do
      studio_1 = Studio.create(name: "Universal Studio")
      studio_2 = Studio.create(name: "Disney")

      actor_1 = Actor.create!(name: "Daniel Mackey", age: 23)
      actor_2 = Actor.create!(name: "Chris Fisher", age:42)
      actor_3 = Actor.create!(name: "John Smith", age: 32)
      actor_4 = Actor.create!(name: "Anduin Wrynn", age: 28)

      movie_1 = studio_2.movies.create!(title: "A New Hope", creation_year: 1978, genre: "Debatably-Space-Opera")
      movie_2 = studio_2.movies.create!(title: "The Empire Strikes Back", creation_year: 1982, genre: "Debatably-Space-Opera")
      movie_3 = studio_2.movies.create!(title: "Spiderman", creation_year: 2014, genre: "Action")
      movie_4 = studio_1.movies.create!(title: "Jurassic Park", creation_year: 1991, genre: "Thriller")
      movie_5 = studio_1.movies.create!(title: "Jaws", creation_year: 1993, genre: "Thriller")

      actor_1.movies << movie_1
      actor_1.movies << movie_2
      actor_2.movies << movie_1
      actor_2.movies << movie_2
      actor_3.movies << movie_3
      actor_3.movies << movie_4
      actor_4.movies << movie_4
      actor_4.movies << movie_5

      visit "/movies/#{movie_3.id}"

      within "#actors" do
        expect(page).to have_content(actor_3.name)
      end

      fill_in :name, with: "#{actor_4.name}"
      click_on "Add Actor"

      expect(current_path).to eq("/movies/#{movie_3.id}")

      within "#actors" do
        expect(page).to have_content(actor_3.name)
        expect(page).to have_content(actor_4.name)
      end
    end
  end
end
