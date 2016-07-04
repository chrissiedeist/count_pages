require 'rails_helper'

RSpec.describe ReadBook, type: :model do
  describe "validations" do
    it "is invalid without a user_id" do
      read_book = ReadBook.new(:book_id => 1, :num_pages => 100)

      expect(read_book).to be_invalid
    end

    it "is invalid without a book_id" do
      read_book = ReadBook.new(:user_id => 1, :num_pages => 100)

      expect(read_book).to be_invalid
    end

    it "is invalid without num_pages" do
      read_book = ReadBook.new(:book_id => 1, :user_id => 100)

      expect(read_book).to be_invalid
    end

    it "does not allow duplicate entries" do
      read_book = ReadBook.create(
        :book_id => 1, 
        :user_id => 100,
        :num_pages => 100,
      )

      expect do
        duplicate_read_book = ReadBook.create!(
          :book_id => 1, 
          :user_id => 100,
          :num_pages => 100,
        )
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
