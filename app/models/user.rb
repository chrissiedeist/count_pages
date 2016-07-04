class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :read_books
  has_many :books, :through => :read_books

  def read(book)
    self.read_books.create(
      :num_pages => book.num_pages,
      :book_id => book.id, 
      :user_id => self.id,
    )
  end

  def read_pages
    self.read_books.sum(:num_pages)
  end
end
