class ReadBooksController < ApplicationController
  def read
    @book = Book.find(params[:id])
    current_user.read(@book)

    redirect_to :back
  end

end
