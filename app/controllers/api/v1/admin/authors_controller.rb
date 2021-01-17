class Api::V1::Admin::AuthorsController < Api::V1::Admin::BaseController
  before_action :set_author, except: [:index, :create]

	def create
		@author = Author.create!(author_params)
	end

	def update
		@author.update!(author_params)
	end

	def destroy
		@author.destroy
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
