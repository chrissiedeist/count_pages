class AddReadDateToReadBooks < ActiveRecord::Migration
  def change
    add_column :read_books, :read_date, :datetime, :null => false, :default => Date.today
  end
end
