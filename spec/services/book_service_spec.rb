require 'rails_helper'

RSpec.describe BookService, type: :model do
  describe "self.build" do
    it "creates a book" do
      params = {:title => "Book title", :isbn => "11111111" }
      book = BookService.build(params)

      expect(book).to be_a(Book)
    end
  end
end
