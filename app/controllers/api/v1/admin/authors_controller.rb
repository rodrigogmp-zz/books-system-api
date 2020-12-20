class Api::V1::Admin::AuthorsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_author, except: [:index, :create]

	def create
		@author = Author.create(author_params)
		if @author.errors.any?
			return render json: { errors: @author.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		unless @author.update(author_params)
			return render json: { errors: @author.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		@author.destroy
	end

	def show
	end

	def index
		params[:page] ||= 1
		params[:per_page] ||= 10

    @authors = 
      Author
				.filter(by_name: params[:name])
				.paginate(page: params[:page], 
									per_page: params[:per_page])
		
	end

	private

	def author_params
    params.require(:name)
		params.permit(:name, :avatar)
  end
  
  def set_author
    @author = Author.find(params[:id])
  end
end
