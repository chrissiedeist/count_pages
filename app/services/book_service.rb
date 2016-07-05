class BookService 
  def self.build(book_params)
    Book.new(
      :title => book_params[:title],
      :isbn => book_params[:isbn],
      :num_pages => book_params[:num_pages] || _get_num_pages(book_params[:isbn]),
    )
  end

  def self._get_num_pages(isbn)
    # fetch based on isbn
    # https://www.googleapis.com/books/v1/volumes?q=isbn:9780664236588
    100
  end
end
