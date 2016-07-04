class ReadBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :user_id, :book_id, :num_pages, :presence => true
  validates_uniqueness_of :book_id, :scope => :user_id
end
