# As a user,
# When I visit the studio index page
# I see a list of all of the movie studios
# And underneath each studio, I see the names of all of its movies.

require 'rails_helper'

describe "Studio Index Page" do
  describe "As a visitor" do
    it "shows a list of all modie studios" do
      studio_1 = Studio.create(name: "Universal Studio")
      studio_2 = Studio.create(name: "Disney")

      movie_1 = studio_2.movies.create(title: "A New Hope")
      movie_2 = studio_2.movies.create(title: "The Empire Strikes Back")
      movie_3 = studio_2.movies.create(title: "Spiderman")
      movie_4 = studio_1.movies.create(title: "Jurassic Park")
      movie_5 = studio_1.movies.create(title: "Jaws")

      visit '/studios'
      within "#studio-#{studio_1.id}" do
        expect(page).to have_content(studio_1.name)
      end

      within "#studio-#{studio_2.id}" do
        expect(page).to have_content(studio_2.name)
      end
    end

    it "shows each movie name under each studio" do
      studio_1 = Studio.create(name: "Universal Studio")
      studio_2 = Studio.create(name: "Disney")

      movie_1 = studio_2.movies.create(title: "A New Hope")
      movie_2 = studio_2.movies.create(title: "The Empire Strikes Back")
      movie_3 = studio_2.movies.create(title: "Spiderman")
      movie_4 = studio_1.movies.create(title: "Jurassic Park")
      movie_5 = studio_1.movies.create(title: "Jaws")

      visit '/studios'
      within "#studio-#{studio_1.id}" do
        expect(page).to have_content(studio_1.name)
        expect(page).to have_content(movie_4.name)
        expect(page).to have_content(movie_5.name)
      end

      within "#studio-#{studio_2.id}" do
        expect(page).to have_content(studio_2.name)
        expect(page).to have_content(movie_1.name)
        expect(page).to have_content(movie_2.name)
        expect(page).to have_content(movie_3.name)
      end
    end
  end
end
