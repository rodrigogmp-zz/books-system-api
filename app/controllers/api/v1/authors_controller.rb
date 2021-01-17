class Api::V1::AuthorsController < ApplicationController
  before_action :set_author, except: :index

	def index
		params[:page] ||= 1
		params[:per_page] ||= 10

    @authors = 
      Author
        .filter(by_name: params[:name],
                by_alphabetic_order: params[:order])
				.paginate(page: params[:page], 
									per_page: params[:per_page])
		
  end

  def books
		params[:page] ||= 1
		params[:per_page] ||= 10
    
    @books = BooksFilter.call(class_instance: @author, params: params)
	end
  
  private

  def set_author
    @author = Author.find(params[:id])
  end
end
