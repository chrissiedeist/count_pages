require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    user = FactoryGirl.create(:user)

    expect(user).to be_valid
  end

  it "has an email" do
    user = FactoryGirl.create(
      :user,
      :email => "chrissie3@gmail.com",
      :password => "abcd1234",
    )

    expect(user).to be_valid
    expect(user.email).to eq("chrissie3@gmail.com")
  end

  it "has many read_books" do
    user = FactoryGirl.create(:user) 

    expect(user.read_books.count).to eq(0)
  end

  it "can read a book" do
    user = FactoryGirl.create(:user) 
    book = FactoryGirl.create(
      :book,
      :num_pages => 100
    )

    user.read(book)

    expect(user.read_books.count).to eq(1)
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
