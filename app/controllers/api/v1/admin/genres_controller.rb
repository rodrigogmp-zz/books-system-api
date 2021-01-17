class Api::V1::Admin::GenresController < Api::V1::Admin::BaseController
	before_action :set_genre, except: [:index, :create]

	def create
		@genre = Genre.create!(genre_params)
	end

	def update
		@genre.update!(genre_params)
	end

	def destroy
		@genre.destroy
	end

	private

	def genre_params
		params.require(:name)
		params.permit(:name)
	end

	def set_genre
		@genre = Genre.find(params[:id])
	end
end
