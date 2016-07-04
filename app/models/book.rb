class Book < ActiveRecord::Base
  has_many :read_books
  has_many :users, :through => :read_books

  validates :num_pages, :title, :presence => true
end
