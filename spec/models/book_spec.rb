require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it "is invalid without num_pages" do
      book = Book.new(
        :title => "Book title",
      )
      expect(book).to be_invalid
    end

    it "is invalid without a title" do
      book = Book.new(
        :num_pages => 100
      )
      expect(book).to be_invalid
    end
  end
end
