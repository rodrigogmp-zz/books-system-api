class ApplicationController < ActionController::API
	include DeviseTokenAuth::Concerns::SetUserByToken

	rescue_from ActiveRecord::RecordNotFound, with: :show_not_found_errors

	def show_not_found_errors(exception)
		render json: { error: exception.message }, status: :not_found
	end
end
