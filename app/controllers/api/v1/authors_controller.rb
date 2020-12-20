class Api::V1::AuthorsController < ApplicationController
  before_action :set_author, only: :show
  def show
	end

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
  
  private

  def set_author
    @author = Author.find(params[:id])
  end
end
