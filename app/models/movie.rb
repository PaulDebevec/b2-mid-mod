class Movie < ApplicationRecord
  validates_presence_of :title
  belongs_to :studio
end
