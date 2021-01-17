class Api::V1::Admin::BooksController < Api::V1::Admin::BaseController
  before_action :set_book, except: [:index, :create]

  def create
    @book = BookServices::Create.call(params: create_book_params)
	end

	def update
    # @book.update!(book_params)
    @book = BookServices::Update.call(params: update_book_params, book: @book)
	end

  def destroy
		@book.destroy
	end

	private

  def create_book_params
    require_parameters(parameters: 
                        [
                          :title, 
                          :description, 
                          :author_id, 
                          :publishing_company_id, 
                          :genre_id
                        ]
                      )
		params.permit(:title, :description, :author_id, :publishing_company_id, :genre_id, :image)
  end

  def update_book_params
    params.permit(:title, :description, :author_id, :publishing_company_id, :genre_id, :image)
  end
  
  def set_genre
    @genre = Genre.find(params[:genre_id])
  end

	def set_publishing_company
		@publishing_company = PublishingCompany.find(params[:publishing_company_id])
  end

  def set_author
    @author = Author.find(params[:author_id])
  end
  
  def set_book
    @book = Book.find(params[:id])
  end
end
