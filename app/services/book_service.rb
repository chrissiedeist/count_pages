require 'net/http'

class BookService 
  def self.build(book_params)
    Book.new(
      :title => book_params[:title],
      :isbn => book_params[:isbn],
      :num_pages => book_params[:num_pages] || _get_num_pages(book_params[:isbn]),
    )
  end
end
