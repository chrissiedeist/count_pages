class ChangePagesToNumPages < ActiveRecord::Migration
  def change
    rename_column :books, :pages, :num_pages
    rename_column :read_books, :page_count, :num_pages
  end
end
