class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :read_books
  has_many :books, :through => :read_books

  validates :name, :presence => true

  def read(book)
    self.read_books.create(
      :num_pages => book.num_pages,
      :book_id => book.id, 
      :user_id => self.id,
      :read_date => Date.today,
    )
  end

  def unread(book)
    ReadBook.delete_all(
      :book_id => book.id, 
      :user_id => self.id,
    )
  end

  def has_read?(book)
    self.books.where(:id => book.id).present?
  end

  def read_pages
    self.read_books.sum(:num_pages)
  end

  def read_date(book)
    read_book = self.read_books.where(:book_id => book.id).first
    read_book.read_date.strftime("%m/%d/%Y") if read_book
  end
end
