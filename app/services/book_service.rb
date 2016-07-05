require 'net/http'

class BookService 
  def self.build(book_params)
    Book.new(
      :title => book_params[:title],
      :isbn => book_params[:isbn],
      :num_pages => book_params[:num_pages] || _get_num_pages(book_params[:isbn]),
    )
  end

  def self._get_num_pages(isbn)
    # uri = URI('https://www.googleapis.com/books/v1/volumes')
    # params = { :isbn=> isbn}
    # uri.query = URI.encode_www_form(params)
    #
    # res = Net::HTTP.get_response(uri)
    #puts res.body if res.is_a?(Net::HTTPSuccess)
    100
  end
end
