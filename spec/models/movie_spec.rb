require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "validations" do
    it {should validate_presence_of(:title)}
  end

  describe "relationships" do
    it {should belong_to(:studio)}
  end
end
