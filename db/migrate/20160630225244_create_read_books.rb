class CreateReadBooks < ActiveRecord::Migration
  def change
    create_table :read_books, :id => false do |t|
      t.integer :book_id,  null: false
      t.integer :user_id,  null: false
      t.integer :page_count
    end
  end
end
