require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    user = FactoryGirl.create(:user)

    expect(user).to be_valid
  end

  describe "validations" do
    it "is invalid without an email" do
      user = FactoryGirl.build(
        :user,
        :email => nil,
      )

      expect(user).to be_invalid
    end
  end

  describe "associations" do
    it "initially has no read_books" do
      user = FactoryGirl.create(:user) 

      expect(user.read_books.count).to eq(0)
    end

    it "initially has no books" do
      user = FactoryGirl.create(:user) 

      expect(user.books.count).to eq(0)
    end
  end

  describe "has_read?" do
    it "is true if the user has read the book" do
      user = FactoryGirl.create(:user) 
      book = FactoryGirl.create(
        :book,
        :num_pages => 100
      )

      user.read(book)
      expect(user.has_read?(book)).to be_truthy
    end

    it "is falseif the user has not read the book" do
      user = FactoryGirl.create(:user) 
      book = FactoryGirl.create(
        :book,
        :num_pages => 100
      )

      expect(user.has_read?(book)).to be_truthy
    end
  end

  describe "read" do
    it "creates a read_book with the given book id" do
      user = FactoryGirl.create(:user) 
      book = FactoryGirl.create(
        :book,
        :num_pages => 100
      )

      user.read(book)

      expect(user.read_books.count).to eq(1)
      expect(user.read_books.first.num_pages).to eq(100)
    end
  end

  describe "read_pages" do
    it "is initially 0" do
      user = FactoryGirl.create(:user) 

      expect(user.read_pages).to eq(0)
    end

    it "equals the sum of all paged counts of read_books" do
      user = FactoryGirl.create(:user) 
      ReadBook.create(
       :num_pages => 100,
       :user_id => user.id,
       :book_id => 1
      )
  
      expect(user.read_pages).to eq(100)
    end
  end
end
