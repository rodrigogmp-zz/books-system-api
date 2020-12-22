class Api::V1::Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
	before_action :set_genre, except: [:index, :create]

	def create
		@genre = Genre.create(genre_params)
		if @genre.errors.any?
			return render json: { errors: @genre.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		unless @genre.update(genre_params)
			return render json: { errors: @genre.errors.full_messages }, status: :unprocessable_entity
		end
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
