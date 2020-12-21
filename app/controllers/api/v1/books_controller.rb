class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: :show

	def index
		params[:page] ||= 1
		params[:per_page] ||= 10

    @books = 
      Book
        .filter(by_title: params[:title],
                by_description: params[:description],
                by_title_or_description: params[:title_or_description],
                by_genre: params[:genre],
                by_author: params[:author],
                by_publishing_company: params[:publishing_company],
                by_alphabetic_order: params[:order])
				.paginate(page: params[:page], 
                  per_page: params[:per_page])
        .includes(:author, :publishing_company, :genre)
		
  end
  
  private

  def set_book
    @book = Book.find(params[:id])
  end
end
