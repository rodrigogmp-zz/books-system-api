class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: :show

	def index
		params[:page] ||= 1
    params[:per_page] ||= 10
    
    @books = BookServices::Filter.call(params: params)
  end
  
  private

  def set_book
    @book = Book.find(params[:id])
  end
end
