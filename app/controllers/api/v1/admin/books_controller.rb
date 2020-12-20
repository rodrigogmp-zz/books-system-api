class Api::V1::Admin::BooksController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_publishing_company
  before_action :set_book, except: [:index, :create]

	def create
		@book = Book.create(book_params)
		if @book.errors.any?
			return render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		unless @book.update(book_params)
			return render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		@book.destroy
	end

	def show
	end

	def index
		params[:page] ||= 1
		params[:per_page] ||= 10

    @books = 
      @publishing_company
        .books
        .where(publishing_company_id: params[:publishing_company_id])
				.filter(by_name: params[:name])
				.paginate(page: params[:page], 
									per_page: params[:per_page])
		
	end

	private

	def book_params
    params.require(:title)
    params.require(:description)
    params.require(:author_id)
    params.require(:image)
		params.permit(:title, :description, :author_id, :image)
	end

	def set_publishing_company
		@publishing_company = PublishingCompany.find(params[:publishing_company_id])
  end
  
  def set_book
    @book = Book.find(params[:id])
  end
end
